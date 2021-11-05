*******************************************
Comment effectuer une regression linéaire ?
*******************************************

A l'instar de l'ajustement pour une lorentzienne, l'idée est ici aussi d'appliquer le méthode des moindres carrés. Cependant, nous avons désormais une équation plus simple:

.. math::
    :label: y(x)

    y = a_0 + a_1 x

L'objectif est donc de trouver la combinaison :math:`\{a_0, a_1\}` de sorte à minimiser les coefficients

.. math::
    :label: E

    E(a_0,a_1) = \sum_{i=1}^{N} W_i (a_1 x_i + a_0 - y_i)^2

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
            \sum_{i=1}^N W_i 2(a_1 x_i + a_0 - y_i) &= 0 \\
            \sum_{i=1}^N W_i 2(a_1 x_i + a_0 - y_i) x_i &= 0
        \end{cases}\,
    \end{equation}

Qui un fois décomposé  nous donne:

.. math::
    :label: sums
    
    \begin{equation}
        \begin{cases}
            a_1 \sum_{i=1}^N W_i x_i + a_0 \sum_{i=1}^N W_i &= \sum_{i=1}^N W_i y_i \\
            a_1 \sum_{i=1}^N W_i x_i^2 + a_0 \sum_{i=1}^N W_i x_i &= \sum_{i=1}^N W_i y_i x_i
        \end{cases}\,
    \end{equation}

Si on divise tout par :math:`N`, on obtient la moyenne de tous les termes:

.. math::
    :label: sys

    \begin{equation}
        \begin{cases}
            a_1 \langle W \rangle \langle x \rangle   &+ a_0 \langle W \rangle       &= \langle W \rangle \langle y \rangle \\
            a_1 \langle W \rangle \langle x^2 \rangle &+ a_0 \langle W \rangle \langle x \rangle   &= \langle W \rangle \langle y x \rangle \\
        \end{cases}\,
    \end{equation}

Ainsi, on peut tout diviser par :math:`\langle W \rangle` et écrire ce système sous la forme d'une équation matricielle:

.. math::
    :label: matrix

    \begin{pmatrix}
        1                   & \langle x \rangle     \\
        \langle x \rangle   & \langle x^2 \rangle
    \end{pmatrix}.
    \begin{pmatrix}
        a_0 \\
        a_1
    \end{pmatrix}=
    \begin{pmatrix}
        \langle y \rangle \\
        \langle y x \rangle
    \end{pmatrix}

On peut donc déterminer les coefficients :math:`a_0, a_1`
    
.. math::
    :label: a0_det

    a_0 = \frac{
    \begin{vmatrix}
        \langle y \rangle    & \langle x \rangle   \\
        \langle yx \rangle   & \langle x^2 \rangle \\
    \end{vmatrix}
    }{
    \begin{vmatrix}
        1                   & \langle x \rangle    \\
        \langle x \rangle   & \langle x^2 \rangle 
    \end{vmatrix}
    }

.. math::
    :label: a0

    a_0 = \frac  { \langle y \rangle * \langle x^2 \rangle - \langle y*x \rangle * \langle x \rangle }
                { 1 * \langle x^2 \rangle - \langle x \rangle * \langle x \rangle }

.. math::
    :label: a1_det

    a_1 &= \frac{
    \begin{vmatrix}
        1                    & \langle y \rangle    \\
        \langle x \rangle    & \langle yx \rangle   
    \end{vmatrix}
    }{
    \begin{vmatrix}
        1                   & \langle x \rangle    \\
        \langle x \rangle   & \langle x^2 \rangle 
    \end{vmatrix}
    }

    &

.. math::
    :label: a1

    a_1 = \frac  { \langle yx \rangle - \langle x \rangle * \langle y \rangle }
                { \langle x^2 \rangle - \langle x \rangle * \langle x \rangle }