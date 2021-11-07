******************************
Ajustement d'une Lorentzienne
******************************

L'objectif est de faire concorder une forme de spectre théorique, qui prend la forme d'une lorentzienne à un nuage de point.

En théorie
==========

La lorentienne est définie par :

.. math::
    :label: F(w)

    F(\omega) = \frac{S}{\pi} * \frac{\gamma}{(\omega-\omega_m)^2 + \gamma^2}

Où :math:`\omega` est la fréquence d'émission; :math:`\omega_m` est la fréquence "moyenne", correspondant au centre de la lorentzienne; :math:`S = \int_{-\infty}^{\infty} F(\omega) d\omega` représente l'aire totale sous la courbe du spectre (assimilable à l'énergie totale); :math:`\gamma` est le coefficient d'élargissement du gas considéré.

Afin de pouvoir réaliser cet ajustement théorique, nous avons besoin de transformer cette fonction de sorte à ce qu'elle prenne la forme d'un polynôme. On prend donc son inverse:

.. math::
    :label: F(w)-1

    F(\omega)^{-1} &= \frac{\pi}{S} \frac{(\omega-\omega_m)^2 + \gamma^2}{\gamma}

    & = \frac{\pi}{S\gamma}\omega^2 - \frac{2\pi\omega_m}{S\gamma}\omega + \frac{\pi(\omega_m^2 + \gamma^2)}{S\gamma}

Pour le programm, les valeurs d'omega risquent d'être trop grande. On définit alors :

.. math::
    :label: x

    x &= \frac{\omega - \bar{\omega}}{\sqrt{\overline{\omega^2} - \bar{\omega}^2}}

    & \equiv \frac{\omega - \bar{\omega}}{\sigma}
    
Ce qui nous donne :

.. math::
    :label: F(x)-1

    F(\omega)^{-1} = \frac{\pi\gamma^2}{S\gamma}x^2 + \frac{2\pi\sigma}{S\gamma}(\bar{\omega}-\omega_m)x + \frac{\pi}{S\gamma}(\gamma^2 + (\bar{\omega} - \omega_m)^2)

Que l'on peut réecrire sous la forme:

.. math::
    :label: y(x)
    
    F(\omega)^{-1} = a_2x^2 + a_1x + a_0

L'objectif est donc de trouver la combinaison :math:`\{a_0, a_1, a_2\}` de sorte à minimiser les coefficients

.. math::
    :label: E

    E(a_0,a_1,a_2) = \sum_{i=1}^{N} W_i (a_2 x_i^2 + a_1 x_i + a_0 - y_i)^2

Pour trouver un minimum, on cherche donc les points où la dérivée s'annule, ce qui nous donne:

.. math::
    :label: E'=0

    \begin{equation}
        \begin{cases}
            E_{a_0}' &= 0 \\
            E_{a_1}' &= 0 \\
            E_{a_2}' &= 0
        \end{cases}\,\rightarrow
        \begin{cases}
            \sum_{i=1}^N W_i 2(a_2 x_i^2 + a_1 x_i + a_0 - y_i) &= 0 \\
            \sum_{i=1}^N W_i 2(a_2 x_i^2 + a_1 x_i + a_0 - y_i) x_i &= 0 \\
            \sum_{i=1}^N W_i 2(a_2 x_i^2 + a_1 x_i + a_0 - y_i) x_i^2 &= 0
        \end{cases}\,
    \end{equation}

Qui un fois décomposé  nous donne:

.. math::
    :label: sums
    
    \begin{equation}
        \begin{cases}
            a_2 \sum_{i=1}^N W_i x_i^2 + a_1 \sum_{i=1}^N W_i x_i + a_0 \sum_{i=1}^N W_i &= \sum_{i=1}^N W_i y_i \\
            a_2 \sum_{i=1}^N W_i x_i^3 + a_1 \sum_{i=1}^N W_i x_i^2 + a_0 \sum_{i=1}^N W_i x_i &= \sum_{i=1}^N W_i y_i x_i \\
            a_2 \sum_{i=1}^N W_i x_i^4 + a_1 \sum_{i=1}^N W_i x_i^3 + a_0 \sum_{i=1}^N W_i x_i^2 &= \sum_{i=1}^N W_i y_i x_i^2 \\
        \end{cases}\,
    \end{equation}

Si on divise tout par :math:`N`, on obtient la moyenne de tous les termes:

.. math::
    :label: sys

    \begin{equation}
        \begin{cases}
            a_2 \langle W \rangle \langle x^2 \rangle &+ a_1 \langle W \rangle \langle x \rangle   &+ a_0 \langle W \rangle       &= \langle W \rangle \langle y \rangle \\
            a_2 \langle W \rangle \langle x^3 \rangle &+ a_1 \langle W \rangle \langle x^2 \rangle &+ a_0 \langle W \rangle \langle x \rangle   &= \langle W \rangle \langle y x \rangle \\
            a_2 \langle W \rangle \langle x^4 \rangle &+ a_1 \langle W \rangle \langle x^3 \rangle &+ a_0 \langle W \rangle \langle x^2 \rangle &= \langle W \rangle \langle y x^2 \rangle \\
        \end{cases}\,
    \end{equation}

Ainsi, on peut tout diviser par :math:`\langle W \rangle` et écrire ce système sous la forme d'une équation matricielle:

.. math::
    :label: matrix

    \begin{pmatrix}
        1     & \langle x \rangle   & \langle x^2 \rangle \\
        \langle x \rangle   & \langle x^2 \rangle & \langle x^3 \rangle \\
        \langle x^2 \rangle & \langle x^3 \rangle & \langle x^4 \rangle 
    \end{pmatrix}.
    \begin{pmatrix}
        a_0 \\
        a_1 \\
        a_2
    \end{pmatrix}=
    \begin{pmatrix}
        \langle y \rangle \\
        \langle y x \rangle \\
        \langle y x^2 \rangle
    \end{pmatrix}

On peut donc déterminer les coefficients :math:`a_0, a_1, a_2`
    
.. math::
    :label: a0

    a_0 = \frac{
    \begin{vmatrix}
        \langle y \rangle    & \langle x \rangle   & \langle x^2 \rangle \\
        \langle yx \rangle   & \langle x^2 \rangle & \langle x^3 \rangle \\
        \langle yx^2 \rangle & \langle x^3 \rangle & \langle x^4 \rangle 
    \end{vmatrix}
    }{
    \begin{vmatrix}
        1     & \langle x \rangle   & \langle x^2 \rangle \\
        \langle x \rangle   & \langle x^2 \rangle & \langle x^3 \rangle \\
        \langle x^2 \rangle & \langle x^3 \rangle & \langle x^4 \rangle 
    \end{vmatrix}
    }

.. math::
    :label: a1

    a_1 &= \frac{
    \begin{vmatrix}
        \langle 1 \rangle    & \langle y \rangle    & \langle x^2 \rangle \\
        \langle x \rangle    & \langle yx \rangle   & \langle x^3 \rangle \\
        \langle x^2 \rangle  & \langle yx^2 \rangle & \langle x^4 \rangle 
    \end{vmatrix}
    }{
    \begin{vmatrix}
        1     & \langle x \rangle   & \langle x^2 \rangle \\
        \langle x \rangle   & \langle x^2 \rangle & \langle x^3 \rangle \\
        \langle x^2 \rangle & \langle x^3 \rangle & \langle x^4 \rangle 
    \end{vmatrix}
    }

.. math::
    :label: a2

    a_2 &= \frac{
    \begin{vmatrix}
        \langle 1 \rangle    & \langle x \rangle   & \langle y \rangle    \\
        \langle x \rangle    & \langle x^2 \rangle & \langle yx \rangle   \\
        \langle x^2 \rangle  & \langle x^3 \rangle & \langle yx^2 \rangle 
    \end{vmatrix}
    }{
    \begin{vmatrix}
        1     & \langle x \rangle   & \langle x^2 \rangle \\
        \langle x \rangle   & \langle x^2 \rangle & \langle x^3 \rangle \\
        \langle x^2 \rangle & \langle x^3 \rangle & \langle x^4 \rangle
    \end{vmatrix}
    }

Une fois ces coefficants calculés, on peut alors retrouver les valeurs de :math:`S`, :math:`\gamma` et :math:`\bar{\omega}`. Leur expression peut être récupéré des equations :eq:`F(x)-1` et :eq:`y(x)`

.. math::
    :label: wm

    \bar{\omega} = \langle w \rangle - \sigma \frac{a_1}{2 a_2}

.. math::
    :label: gamma

    \gamma = \sigma \sqrt{\frac{a_0}{a_2} - \frac{a_1^2}{4 a_2^2}}

.. math::
    :label: S

    S = \frac{\pi \sigma}{\sqrt{a_0 a_2 - \frac{a_1^2}{4}}}

Avec ces 3 paramètres, on a alors une description complète de :math:`F(\omega)` tel que décrite initialement dans l'équation :eq:`F(w)`

En pratique
===========

Le programme vient lire un fichier contenant sur chaque ligne une valeur de :math:`F(\omega)`. On sait que ces valeurs sont données pour un :math:`\omega` démarrant à 2280 et chaque ligne incrémente :math:`\omega` de 0,01.

Grâce à ces informations, on a les coordonnées de chaque point. On veut cependant inverser la coordonnée :math:`y` car on s'intéresse à :math:`F(\omega)^{-1}` afin d'avoir une fonction sous la forme d'un polynôme.

Egalement, on calcule pour chaque valeur de :math:`\omega`, la valeur de :math:`x` associée.

A ce moment là, nous avons un nouveau jeu de coordonnées qui vont pouvoir être exploités. On calcule alors les valeurs moyennes des différents éléments (:math:`x`, :math:`y` mais aussi leurs carré etc.). Le calcule de cette moyenne se fait via une routine dédiée.

Une fois cette étape effectuée, on peut désormais calculer les coefficients :math:`a_0`, :math:`a_1` et :math:`a_2`. 

De là, on peut calculer les valeurs de :math:`\bar{\omega}`, :math:`\gamma` et :math:`S`.

En utilisant le premier spectre corrspondant à une pression de 1 atm, on obtient le résultat suivant:

.. figure:: https://vincent.foriel.xyz/wp-content/uploads/2021/11/bokeh_plot-1.png

Cependant, on remarque que la courbe qu'on obtient ne coincide pas totalement avec nos données initiales. En effet, ici, nous avons donné un poids égale à chacune des valeurs experimentales. Or, les valeurs hautes sont plus significatives que les valeurs basses car le bruit devient relativement négligeable. Ainsi, pour éviter d'essayer d'ajuster la courbe au bruit ambient, et ainsi avoir ce genre d'erreur, on donne un poids proportionel à l'intensité au carré de chaque mesure.

De cette façon, on obtient le résultat suivant:

.. figure:: https://vincent.foriel.xyz/wp-content/uploads/2021/11/bokeh_plot-2.png

On peut ainsi répéter l'opération pour les autres spectres, donc pour d'autres pressions, ce qui nous donne:

.. figure:: https://vincent.foriel.xyz/wp-content/uploads/2021/11/bokeh_plot-4.png