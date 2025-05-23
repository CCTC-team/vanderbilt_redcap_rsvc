#!/bin/bash

# Load environment variables from .env file
if [ -f .env ]; then
  source .env
fi

if [ -z "$REDCAP_API_TOKEN" ]; then
  echo "Environment variable REDCAP_API_TOKEN is not set. Exiting."
  exit 1
fi

# Default values
prompt_mode=false
upload=false

# Parse arguments
while [[ "$#" -gt 0 ]]; do
  case "$1" in
    --cur_tag)
      CUR_TAG="$2"
      shift 2
      ;;
    --comp_tag)
      COMP_TAG="$2"
      shift 2
      ;;
    --start_date)
      START_DATE="$2"
      shift 2
      ;;
    --end_date)
      END_DATE="$2"
      shift 2
      ;;
    --prompt)
      prompt_mode=true
      shift
      ;;
    --upload)
      upload=true
      shift
      ;;
    *)
      echo "Unknown option: $1" >&2
      exit 1
      ;;
  esac
done

# Handle prompt mode
if [[ "$prompt_mode" = true ]]; then
  echo "Choose Mode"
  echo "1) Tags"
  echo "2) Dates"
  read -rp "Enter 1 or 2: " choice

  case "$choice" in
    1)
      read -rp "Enter current tag: " CUR_TAG
      read -rp "Enter comparison tag: " COMP_TAG
      ;;
    2)
      read -rp "Enter start date (YYYY-MM-DD): " START_DATE
      read -rp "Enter end date (YYYY-MM-DD): " END_DATE
      ;;
    *)
      echo "Invalid choice. Exiting."
      exit 1
      ;;
  esac
fi

awk_script='$3 ~ /\.feature$/ {
  added[$3] += $1;
  deleted[$3] += $2;
  files[$3] = 1;
}
END {
  total_added = 0;
  total_deleted = 0;
  printf "%10s %10s %10s   %s\n", "Added", "Deleted", "Total", "File";
  for (file in files) {
    file_added = added[file];
    file_deleted = deleted[file];
    file_total = file_added + file_deleted;
    total_added += file_added;
    total_deleted += file_deleted;

      # Get the filename like A.6.4.200.feature
      n = split(file, path_parts, "/");
      base = path_parts[n];

      # Strip ".feature"
      sub(/\.feature$/, "", base);

      # Split into letter + parts
      split(base, parts, "\\.");

      # Normalize
      letter = toupper(parts[1]);
      part1 = parts[2];
      part2 = parts[3];
      part3 = sprintf("%04d", parts[4]);  # pad to 4 digits

      # Skip anything not A, B, or C
      if (letter != "A" && letter != "B" && letter != "C") {
        continue;
      }

      # Generate the feature name
      feature = letter "." part1 "." part2 "." part3 ".";

      if (upload == "true") {
        cmd = "sh push_lines_changes.sh \"" feature "\" " file_added " " file_deleted " " file_total;
        system(cmd)
        printf "%10d %10d %10d   %s - UPLOADED\n", file_added, file_deleted, file_total, feature;
      } else {
        # Use the normalized feature name
        printf "%10d %10d %10d   %s\n", file_added, file_deleted, file_total, feature;
      }
  }
  printf "%s\n", "---------------------------------------------------------------";
  printf "%10d %10d %10d   %s\n", total_added, total_deleted, total_added + total_deleted, "TOTAL";
}'


# Validate input
if [[ -n "$CUR_TAG" && -n "$COMP_TAG" ]]; then
  echo "Using tags: CURRENT_TAG=$CUR_TAG vs COMPARISON_TAG=$COMP_TAG"

    #Only if empty Start Date
    if [ -z $START_DATE ]; then
      START_DATE=$(git log -1 --format=%ad --date=short $COMP_TAG)
    fi

    #Only if empty End Date
    if [ -z $END_DATE ]; then
      END_DATE=$(git log -1 --format=%ad --date=short $CUR_TAG)
    fi

elif [[ -n "$START_DATE" && -n "$END_DATE" ]]; then
  echo "Using dates: START_DATE=$START_DATE => END_DATE=$END_DATE"

else
  #Only if empty Current Tag
  if [ -z $CUR_TAG ]; then
    CUR_TAG=$(git tag --sort=-v:refname | head -n 1)
  fi

  #Only if empty Comparison Tag
  if [ -z $COMP_TAG ]; then
    COMP_TAG=$(git tag --sort=-creatordate | sed -n 2p)
  fi

  #Only if empty Start Date
  if [ -z $START_DATE ]; then
    START_DATE=$(git log -1 --format=%ad --date=short $COMP_TAG)
  fi

  #Only if empty End Date
  if [ -z $END_DATE ]; then
    END_DATE=$(git log -1 --format=%ad --date=short $CUR_TAG)
  fi

  echo "DEFAULT MODE: Takes the most recent tag and compares it to the previous tag.\n"

fi

# Get the line changes for .feature files between the dates
git log --since="$START_DATE" --until="$END_DATE" --pretty=tformat: --numstat --ignore-space-change | awk -F'\t' -v upload="$upload" "$awk_script"

if [ -z $CUR_TAG ]; then
  echo ""
else
  echo "\nTAGS: \n CURRENT_TAG: $CUR_TAG \n COMPARISON_TAG: $COMP_TAG\n"
fi
echo "DATES:\n START_DATE: $START_DATE \n END_DATE: $END_DATE\n"