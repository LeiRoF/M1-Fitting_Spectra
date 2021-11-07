*******************
Guide d'utilisation
*******************

Dépendences
===========

- Fortran 90
- Python 3.9 & pip

Installation
============

1) Placez vous dans le dossier de votre choix, puis clonez le répertoire git via la commande :

.. code-block::

    git clone https://gitlab.com/LeiRoF/fitting-spectra

2) Déplacez vous dans le dossier du projet

.. code-block::

    cd fitting-spectra/

3) Installez les dépendances du program Python permettant l'affichage des résultats sous la forme d'un graphique

.. code-block::

    pip install -r ./requirements.txt

4) En utilisant `GFortran <https://gcc.gnu.org/wiki/GFortran>`_, compilez les fichiers fortran

.. code-block::

    gfortran -o fit_spectra ./fit_spectra.f90
    gfortran -o fit_omega ./fit_omega.f90


Utilisation
===========

Ce projet contient 2 programmes indépendants : 

- Fit Spectra a pour but de déterminer une fonction lorentzienne à partir d'un ensemble de points donnés via un fichier dans `./data/`
- Fit Omega permet ensuite de faire une régression linéaire, ce qui permet, dans le contexte de ce projet, de déterminer l'énergie fondamentale de rotation du gaz.

Vous pouvez éditez les fichiers `fit_spectra.f90` et `fit_omega.f90` afin d'y modifier le fichier considéré. Une fois édité, ré-effectuez l'étape 3 de l'installation (compilation des fichiers Fortran)

Lancer Fit Spectra

.. code-block::

    ./fit_spectra

Lancer Fit Omega

.. code-block::

    ./fit_omega

.. note::
    
    Si une erreur apparait à la fin de l'execution du programme et qu'aucune fenêtre ne s'affiche, vous pouvez l'ouvrir manuellement en utilisant votre navigateur pour ouvrir le fichier `plot_spectra.hmtl` ou `plot_omega.html`

