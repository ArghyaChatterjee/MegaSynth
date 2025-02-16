#!/bin/bash

# Define the target path
TARGET_PATH="./generated_scenes"
NUM_SCENES=1


# create scene glb
python create_scenes.py --project_dir "$TARGET_PATH" --num_scenes "$NUM_SCENES"


# render scenes
COUNTER=0
# Iterate over each subdirectory in the target path
for SUBDIR in "$TARGET_PATH/scenes"/*/; do
  # Remove trailing slash from the subdirectory path
  SUBDIR_NAME=$(basename "$SUBDIR")

  # Define the object path and output directory based on the subdirectory name
  SCENE_PATH="$TARGET_PATH/scenes/$SUBDIR_NAME/scenes.glb"
  OUTPUT_DIR="$TARGET_PATH/rendering/$SUBDIR_NAME"

  # Run the Python script with the appropriate arguments
  python render_scenes_rgbd.py --object_path "$SCENE_PATH" --output_dir "$OUTPUT_DIR" --proj_names megasynth --seed $COUNTER

  COUNTER=$((COUNTER + 1))
done
