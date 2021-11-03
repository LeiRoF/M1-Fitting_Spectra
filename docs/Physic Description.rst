******************
Physic description
******************

L'objectif est de faire concorder une forme de spectre théorique, qui prend la forme d'une lorentzienne à un nuage de point.

La lorentienne est définie par :

.. math::

    F(\omega) = \frac{S}{\pi} * \frac{\gamma}{(\omega-\omega_m)^2 + \gamma^2}

Où :math:`\omega` est la fréquence d'émission; :math:`\omega_m` est la fréquence "moyenne", correspondant au centre de la lorentzienne; :math:`S = \int_{-\infty}^{\infty} F(\omega) d\omega` représente l'air totale sous la courbe du spectre (assimilable à l'énergie totale); :math:`\gamma` est le coefficient d'élargissement du gas considéré.

Afin de pouvoir réaliser cet ajustement théorique, nous avons besoin de transformer cette fonction de sorte à ce qu'elle prenne la forme d'un polynôme. On prend donc son inverse:

.. math::

    F(\omega)^{-1} &= \frac{\pi}{S} \frac{(\omega-\omega_m)^2 + \gamma^2}{\gamma}

    & = \frac{\pi}{S\gamma}\omega^2 - \frac{2\pi\omega_m}{S\gamma}\omega + \frac{\pi(\omega_m^2 + \gamma^2)}{S\gamma}

Pour le programm, les valeurs d'omega risquent d'être trop grande. On définit alors :

.. math::

    x &= \frac{\omega - \bar{\omega}}{\sqrt{\bar{\omega^2} - \bar{\omega}^2}}

    & \equiv \frac{\omega - \bar{\omega}}{\sigma}
    
Ce qui nous donne :

.. math::

    F(\omega)^{-1} = \frac{\pi\gamma^2}{S\gamma}x^2 + \frac{2\pi\sigma}{S\gamma}(\bar{\omega}-\omega_m)x + \frac{\pi}{S\gamma}(\gamma^2 + (\bar{\omega} - \omega_m)^2)

Que l'on peut réecrire sous la forme:

.. math::
    
    F(\omega)^{-1} = a_2x^2 + a_1x + a_0

L'objectif est donc de trouver la combinaison :math:`\{a_0, a_1, a_2\}` de sorte à minimiser les coefficients

.. math::

    E(a_0,a_1,a_2) = \sum_{i=1}^{N} W_i (a_2 x_i^2 + a_1 x_i + a_0 - y_i)^2

Pour trouver un minimum, on cherche donc les points où la dérivée s'annule, ce qui nous donne:

.. math::

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
    
    \begin{equation}
        \begin{cases}
            a_2 \sum_{i=1}^N W_i x_i^2 + a_1 \sum_{i=1}^N W_i x_i + a_0 \sum_{i=1}^N W_i &= \sum_{i=1}^N W_i y_i \\
            a_2 \sum_{i=1}^N W_i x_i^3 + a_1 \sum_{i=1}^N W_i x_i^2 + a_0 \sum_{i=1}^N W_i x_i &= \sum_{i=1}^N W_i y_i x_i \\
            a_2 \sum_{i=1}^N W_i x_i^4 + a_1 \sum_{i=1}^N W_i x_i^3 + a_0 \sum_{i=1}^N W_i x_i^2 &= \sum_{i=1}^N W_i y_i x_i^2 \\
        \end{cases}\,
    \end{equation}

Si on divise tout par :math:`N`, on obtient la moyenne de tous les termes:

.. math::

    \begin{equation}
        \begin{cases}
            a_2 <W> <x^2> &+ a_1 <W> <x>   &+ a_0 <W>       &= <W> <y> \\
            a_2 <W> <x^3> &+ a_1 <W> <x^2> &+ a_0 <W> <x>   &= <W> <y> <x> \\
            a_2 <W> <x^4> &+ a_1 <W> <x^3> &+ a_0 <W> <x^2> &= <W> <y> <x^2> \\
        \end{cases}\,
    \end{equation}

Ainsi, on peut tout diviser par :math:`<W>` et écrire ce système sous la forme d'une équation matricielle:

.. math::

    \begin{pmatrix}
        1     & <x>   & <x^2> \\
        <x>   & <x^2> & <x^3> \\
        <x^2> & <x^3> & <x^4> 
    \end{pmatrix}.
    \begin{pmatrix}
        a_0 \\
        a_1 \\
        a_2
    \end{pmatrix}=
    \begin{pmatrix}
        <y> \\
        <y> <x> \\
        <y> <x^2>
    \end{pmatrix}

On peut donc déterminer les coefficients :math:`a_0, a_1, a_2`
    
.. math::

    a_0 = \frac{
    \begin{vmatrix}
        <y>    & <x>   & <x^2> \\
        <yx>   & <x^2> & <x^3> \\
        <yx^2> & <x^3> & <x^4> 
    \end{vmatrix}
    }{
    \begin{vmatrix}
        1     & <x>   & <x^2> \\
        <x>   & <x^2> & <x^3> \\
        <x^2> & <x^3> & <x^4> 
    \end{vmatrix}
    }

.. math::

    a_0 = \frac{<y><x^2><x^4> + <yx><x^3><x^2> + <x><x^3><x^2> + <x><x^3><yx^2> - <yx^2><x^2>^2 - <y><x^3>^2 - <x><yx><x^4>}
    {1<x^2><x^4> + 2<x><x^2><x^3> - <x^2>^3 - 1<x^3>^2 - <x>^2<x^4>}

.. math::

    a_1 &= \frac{
    \begin{vmatrix}
        <1>    & <y>    & <x^2> \\
        <x>    & <yx>   & <x^3> \\
        <x^2>  & <yx^2> & <x^4> 
    \end{vmatrix}
    }{
    \begin{vmatrix}
        1     & <x>   & <x^2> \\
        <x>   & <x^2> & <x^3> \\
        <x^2> & <x^3> & <x^4> 
    \end{vmatrix}
    }

.. math::

    a_2 &= \frac{
    \begin{vmatrix}
        <1>    & <x>   & <y>    \\
        <x>    & <x^2> & <yx>   \\
        <x^2>  & <x^3> & <yx^2> 
    \end{vmatrix}
    }{
    \begin{vmatrix}
        1     & <x>   & <x^2> \\
        <x>   & <x^2> & <x^3> \\
        <x^2> & <x^3> & <x^4>
    \end{vmatrix}
    }