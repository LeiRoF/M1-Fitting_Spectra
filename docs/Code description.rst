************
En pratique
************

Ajustement de la Lorentzienne
=============================

Le programme vient lire un fichier contenant sur chaque ligne une valeur de :math:`F(\omega)`. On sait que ces valeurs sont données pour un :math:`\omega` démarrant à 2280 et chaque ligne incrémente :math:`\omega` de 0,01.

Grâce à ces informations, on a les coordonnées de chaque point. On veut cependant inverser la coordonnée :math:`y` car on s'intéresse à :math:`F(\omega)^{-1}` afin d'avoir une fonction sous la forme d'un polynôme.

Egalement, on calcule pour chaque valeur de :math:`\omega`, la valeur de :math:`x` associée.

A ce moment là, nous avons un nouveau jeu de coordonnées qui vont pouvoir être exploités. On calcule alors les valeurs moyennes des différents éléments (:math:`x`, :math:`y` mais aussi leurs carré etc.). Le calcule de cette moyenne se fait via une routine dédiée.

Une fois cette étape effectuée, on peut désormais calculer les coefficients :math:`a_0`, :math:`a_1` et :math:`a_2`. 

De là, on peut calculer les valeurs de :math:`\bar{\omega}`, :math:`\gamma` et :math:`S`, ce qui nous donne une courbe suivante :

.. figure:: https://vincent.foriel.xyz/wp-content/uploads/2021/11/bokeh_plot.png

