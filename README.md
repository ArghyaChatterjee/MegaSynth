<div align="center">

# MegaSynth: Scaling Up 3D Scene Renstruction with Synthesized Data

</div>

<p align="center">
  <img src="assets/mega_synth_scene.png" alt="Hand Mesh Model" width="800">
</p>

## Requirements
We have tried this on Ubuntu 22.04 with Nvidia RTX 3060 GPU and cuda 12.1.

## Setup the repo
First, clone the repo:
```
https://github.com/ArghyaChatterjee/MegaSynth.git
cd MegaSynth
```

## Installation
Install the system dependencies:
```
sudo apt install libxi6 libsm6 libxext6
```
Create a virtual environment and install the requirements:
```
python3.10 -m venv mega_synth_venv
source mega_synth_venv/bin/activate
pip3 install --upgrade pip setuptools
pip3 install -r requirements.txt
```
This script needs blender binary in addition to `bpy` to execute the rendering script. Install blender `3.6.0` by first downloading the `blender-3.6.0-linux-x64.tar` from the blender website, extract the files and export the folder to the path. For me, it looks like this:
```   
export PATH=/home/arghya/blender/blender-3.6.0-linux-x64:$PATH
```

## Generate Scenes
```
. ./render.sh 
```
Adjust your target number of scenes and also adjust scene parameters in each file.

Rendered Scene 1:

<p align="center">
  <img src="assets/mega_synth_rgb_rendered_scene.png" alt="Hand Mesh Model" width="400">
  <img src="assets/mega_synth_depth_rendered_scene.png" alt="Hand Mesh Model" width="400">
</p>

This script is performing a two-step pipeline for generating and rendering 3D scenes using Blender and Python.

1. **Creating 3D Scenes (GLB format)**
   - Calls `create_scenes.py`, which generates 3D scenes as `.glb` files.
   - The generated scenes are saved inside `./generated_scenes/scenes/`.
   - This script likely places objects in a virtual 3D space, forming a structured environment.

2. **Rendering the Scenes in Blender**
   - Iterates over each scene created in the previous step.
   - Calls `render_scenes_rgbd.py` to render RGB and depth images of the generated `.glb` files.
   - The rendered outputs are stored in `./generated_scenes/rendering/`.

---

<p align="center">
  <img src="assets/scene_1.png" alt="Hand Mesh Model" width="400">
  <img src="assets/scene_1_ext.png" alt="Hand Mesh Model" width="400">
</p>

### **Breakdown of Each Script**
#### **1️⃣ `create_scenes.py`**
- **Purpose**: Generates 3D scenes with objects inside.
- **Key Components**:
  - Uses **randomized procedural generation** to create scenes with walls, objects, and other structures.
  - Exports the generated objects in **GLB format**.
  - Uses Open3D, NumPy, and Matplotlib to visualize and process the generated scenes.
  - Saves scene metadata (size, structure, objects, materials, etc.) in `info_layout.json`.

- **Workflow**:
  - Defines object categories (`lB`, `sB`, `rB`, etc.) with different sizes and properties.
  - Places objects inside the scene, ensuring they do not overlap.
  - Converts the generated `.obj` files to `.glb` using `convert_file()`.

---

<p align="center">
  <img src="assets/scene_2.png" alt="Hand Mesh Model" width="400">
  <img src="assets/scene_2_ext.png" alt="Hand Mesh Model" width="400">
</p>


#### **2️⃣ `render_scenes_rgbd.py`**
- **Purpose**: Renders the generated `.glb` scenes using Blender, capturing RGB-D (color + depth) images.
- **Key Components**:
  - Uses **Blender’s Cycles Engine** for physically accurate rendering.
  - Loads `.glb` scenes and **normalizes** their scale and positioning.
  - Adds lighting, materials, and environmental effects.
  - Uses **multiple camera angles** to capture different perspectives.
  - Saves RGB and depth images in **EXR format**, then converts them to PNG.

- **Workflow**:
  - **Loads the `.glb` scene into Blender**.
  - **Resets the scene** to remove old objects.
  - **Adds lighting & cameras** for rendering.
  - **Renders multiple viewpoints**, storing RGB-D outputs.
  - **Saves camera parameters** in `opencv_cameras.json` for future use.
  - **Cleans up temporary files** after rendering.

<p align="center">
  <img src="assets/scene_3.png" alt="Hand Mesh Model" width="400">
  <img src="assets/scene_3_ext.png" alt="Hand Mesh Model" width="400">
</p>

## Abstract
We propose scaling up 3D scene reconstruction by training with <b>synthesized data</b>. At the core of our work is <b>MegaSynth</b>, a 3D dataset comprising <b>700K scenes</b> (which takes only <b>3 days</b> to generate) - 70 times larger than the prior real dataset DL3DV - dramatically scaling the training data. To enable scalable data generation, our key idea is <b>eliminating semantic information</b>, removing the need to model complex semantic priors such as object affordances and scene composition. Instead, we model scenes with basic spatial structures and geometry primitives, offering scalability. Besides, we control data complexity to facilitate training while loosely aligning it with real-world data distribution to benefit real-world generalization. We explore training LRMs with both MegaSynth and available real data, enabling <b>wide-coverage scene reconstruction within 0.3 second</b>.

## TODO
- [ ] Modify the texture sampling logic. As we synthesize scenes with Adobe internal material maps, we cannot release with the internal materials. Now, we sample a single material for the whole scene as a quick demo, following Zeroverse. We will modify the sampling logic to enable different materials for each shape primmitive. See the sampling logic at L207 and L1252 of ```create_shapes.py```.
- [ ] Release our internal rendering data.
