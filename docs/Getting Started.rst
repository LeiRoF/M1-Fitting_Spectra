*******************
Getting Started
*******************

Dependencies
===========

- Fortran 90
- Python 3.9 & pip

Installation
============

1) Go to the folder of your choice, then clone the git directory with the command :

.. code-block::

    git clone https://gitlab.com/LeiRoF/fitting-spectra

2) Move to the project folder

.. code-block::

    cd fitting-spectra/

3) Install the dependencies of the Python program allowing the display of the results in the form of a graph

.. code-block::

    pip install -r ./requirements.txt

4) Using `GFortran <https://gcc.gnu.org/wiki/GFortran>`_, compile the fortran files

.. code-block::

    gfortran -o fit_spectra ./fit_spectra.f90
    gfortran -o fit_omega ./fit_omega.f90


Usage
===========

This project contains 2 independent programs: 

- Fit Spectra aims to determine a Lorentzian function from a set of given points via a file in `./data/`
- Fit Omega then allows you to do a linear regression, which in the context of this project allows you to determine the fundamental rotational energy of the gas.

You can edit the `fit_spectra.f90` and `fit_omega.f90` files to modify the file in question. Once edited, perform step 3 of the installation (compiling the Fortran files) again

Launch Fit Spectra

.. code-block::

    ./fit_spectra

Run Fit Omega

. code-block::

    ./fit_omega

.. note::
    
    If an error appears at the end of the program execution and no window appears, you can open it manually by using your browser to open the file `plot_spectra.hmtl` or `plot_omega.html`