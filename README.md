<div align="center">

# MegaSynth: Scaling Up 3D Scene Renstruction with Synthesized Data

</div>

<div align="center">
    <a href="https://hwjiang1510.github.io/MegaSynth/"><strong>Project Page</strong></a> |
    <a href="https://arxiv.org/abs/"><strong>Paper</strong></a> | 
    <a href="https://huggingface.co/datasets/hwjiang/MegaSynth"><strong>Dataset</strong></a>
</div>

--------------------------------------------------------------------------------
<br>

![overview.png](assets/overview.png "overview.png")

**Abstract**: We propose scaling up 3D scene reconstruction by training with <b>synthesized data</b>. At the core of our work is <b>MegaSynth</b>, a 3D dataset comprising <b>700K scenes</b> (which takes only <b>3 days</b> to generate) - 70 times larger than the prior real dataset DL3DV - dramatically scaling the training data. To enable scalable data generation, our key idea is <b>eliminating semantic information</b>, removing the need to model complex semantic priors such as object affordances and scene composition. Instead, we model scenes with basic spatial structures and geometry primitives, offering scalability. Besides, we control data complexity to facilitate training while loosely aligning it with real-world data distribution to benefit real-world generalization. We explore training LRMs with both MegaSynth and available real data, enabling <b>wide-coverage scene reconstruction within 0.3 second</b>.


## Installation
```
sudo apt install libxi6 libsm6 libxext6
pip install datasets opencv-python Pillow rich bpy==3.6.0 numpy scipy matplotlib
# install blender, then
export PATH=path/to/blender/:$PATH  # needs blender binary in addition to bpy to run
```

## Generate Scenes
```
. ./render.sh
# adjust your target number of scenes
# all see scene parameters in each file
```

## TODO
- [ ] Modify the texture sampling logic. As we synthesize scenes with Adobe internal material maps, we cannot release with the internal materials. Now, we sample a single material for the whole scene as a quick demo, following Zeroverse. We will modify the sampling logic to enable different materials for each shape primmitive. See the sampling logic at L207 and L1252 of ```create_shapes.py```.
- [ ] Release our internal rendering data.


## BibTex
If you find this code useful, please consider citing:
```
@article{jiang2024megasynth,
  title={MegaSynth: Scaling Up 3D Scene Reconstruction with Synthesized Data},
  author={Jiang, Hanwen and Xu, Zexiang and Xie, Desai and Chen, Ziwen and Jin, Haian and Luan, Fujun and Shu, Zhixin and Zhang, Kai and Bi, Sai and Sun, Xin and Gu, Jiuxiang and Huang, Qixing and Pavlakos, Georgios and Tan, Hao},
  booktitle={arXiv preprint arXiv:},
  year={2024},
}

@article{xie2024lrm,
  title={LRM-Zero: Training Large Reconstruction Models with Synthesized Data},
  author={Xie, Desai and Bi, Sai and Shu, Zhixin and Zhang, Kai and Xu, Zexiang and Zhou, Yi and Pirk, S{\"o}ren and Kaufman, Arie and Sun, Xin and Tan, Hao},
  journal={arXiv preprint arXiv:2406.09371},
  year={2024}
}

@article{xu2018deep,
  title={Deep image-based relighting from optimal sparse samples},
  author={Xu, Zexiang and Sunkavalli, Kalyan and Hadap, Sunil and Ramamoorthi, Ravi},
  journal={ACM Transactions on Graphics (TOG)},
  volume={37},
  number={4},
  pages={126},
  year={2018},
  publisher={ACM}
}
```