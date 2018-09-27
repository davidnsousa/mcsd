---
title: 'MCSD: A MATLAB Tool for Monte-Carlo Simulations of Diffusion in biological Tissues'
tags:
  - diffusion
  - monte-carlo
  - simulation
authors:
  - name: David N. Sousa
    orcid: 0000-0001-7277-6447
    affiliation: 1
  - name: Hugo A. Ferreira
    orcid: 0000-0002-4323-3942
    affiliation: 2
affiliations:
 - name: William James Center for Research, ISPA - Instituto Universitário
   index: 1
 - name: Instituto de Biofísica e Engenharia Biomédica, Faculdade de Ciências da Universidade de Lisboa
   index: 2
date: 8 August 2018
bibliography: paper.bib
---


# Summary

Understanding diffusion processes is particularly important for clinical imaging to distinguish between healthy and pathological tissues or between benign and malignant lesions. Computational models of diffusion allow us to predict specific architectural properties of biological tissues which correlate to the measured values of diffusion imaging, thus providing a deeper understanding of certain pathologies *in vivo*. Here we present a free and open-source MATLAB tool developed for that purpose.

In homogeneous and isotropic media, diffusion has a Gaussian behavior and is statistically described  by Einstein's Brownian motion equation. A probability density function (PDF) of the proportion of particles displaced in a given direction [@einstein1956investigations]. In complex heterogeneous environments such as biological tissues, the movement of water molecules is highly constrained by barriers such as those related to cellular components: membranes, organelles and large proteins, in which case, diffusion has a non-gaussian behavior, and tissue micro-structural complexity is characterized by observing the deviation from a normal distribution [@jensen2010mri].

Diffusion-Weighted Imaging (DWI), Diffusion Kurtosis Imaging (DKI) and Diffusion Tensor Imaging (DTI), are different Magnetic Resonance Imaging (MRI) techniques which take advantage of water diffusion properties in biological tissues for the purpose of characterizing tissue micro-structural complexity *in vivo*. These techniques have shown to be very useful in quantifying the complexity of tissue barriers, and for characterizing microstructural changes due to injury, treatment, disease or even normal physiological changes such as aging, including in cases of anisotropic diffusion, namely the case of white matter in the brain, where diffusion is essentially parallel to axonal membranes but highly restricted in the directions perpendicular to axons [@jensen2005diffusional; @fieremans2011white; @henriques2015exploring; @basser1994estimation; @basser1994mr].

Monte-Carlo simulations can be used to investigate the sensitivity of models of diffusion, kurtosis of diffusion, and anisotropy and further offer a deeper understanding on the various parameters defining the complexity of biological tissues, such as the cell radii distribution and type, permeability of membranes, intracellular volume fraction and values of intracellular and extracellular diffusion. [@lee2013sensitivities; @sousa2015diffusion; @szafer1995theoretical; @meier2003diffusion; @fieremans2010monte]. By correlating theoretical and computational models insights with knowledge acquired from imaging techniques it is possible to better understand various pathologies.

Although some theoretical and computational models were developed in this direction, no simple and free open-source tools were designed and made available for researchers in this field to test their basic predictions. The Monte-Carlo Simulations of Diffusion `MCSD` package and the tutorial we present here were created for that purpose and their aim is to be simple and useful for both beginners and advanced users of MATLAB.

`MCSD` is a simple and free open-source MATLAB [@MATLAB2018] tool designed to simulate diffusion processes in complex environments such as biological tissues. It allows to investigate the sensitivity of models of diffusion, kurtosis of diffusion, and anisotropy, and it can be used to complement our knowledge about microstructural changes due to injury, treatment, disease or even normal physiological changes such as aging. Thus, it is very useful for researchers in medicine, neuroscience and biomedical engineering. Because of its flexibility, it might also be useful for researchers from other fields. 

With this tool it is possible to create 1, 2 or 3-D cell environments and simulate the brownian motion of particles subject to movement constraints, such as permeable or impermeable cell membranes or other types of barriers the user may want to define when designing his own complex environment. Additionally, `MCSD` offers a small set of functions to calculate particles' displacements, and any measures the user may want to defined, as well as their compartmental components in all cartesian directions.

# Installation and details

The MATLAB toolbox `MCSD` is available at https://github.com/davidnsousa/mcsd. In MATLAB the Statistics and Machine Learning Toolbox is required for a complete functioning of the package. `MCSD` is fully compatible with Octave too. To use it download the package and add the folder `mcsd/mcsd` MATLAB/Octave search path via the `addpath()` MATLAB/Octave built-in function. `MCSD` provides the following functions:

* `cells()` designs 1, 2 and 3-D cell environments according to a user defined cell radii distribution and a specified region to pack the cells.
* `rwalkfree()` generates the random walk of one or multiple particles in a free environment without any barriers.
* `rwalk()` generates the random walk of one or multiple particles in the presence of barriers.
* `displacement()` calculates the displacement of the particles in every orthogonal direction.
* `cmeasures()`  calculates a user-defined measure of the particles' displacement distribution in all cartesian directions, including compartmental components.
* `where()` indicates what particles are inside or outside compartments at a specific step of the random walk trajectory.
* `fanisotropy()` calculates the fractional anisotropy of diffusion.

In the MATLAB/Octave command line type `help` followed by the name of each one of the functions above for further details about input and output parameters. In the github repository, at `tutorial/`, the user can also find a tutorial with more details and various examples. A replication script of the tutorial examples is also provided for MATLAB users.

Combining theoretical and computational insights about diffusion processes with the knowledge acquired from imaging techniques has proved to be an important research direction for understanding the micro-structural complexity of biological tissues. But, as yet, no simple and free open-source tools are available for researchers in this field to test their basic predictions. `MCSD` offers such possibility. The functions provided by `MCSD` are highly flexible and useful for the design of complex random walk environments such as biological tissues. In fact, although `MCSD` was developed specifically to simulate diffusion processes in such environments, researchers from other fields might find this package useful as well.
