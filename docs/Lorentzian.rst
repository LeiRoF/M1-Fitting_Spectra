******************************
Adjustment of a Lorentzian
******************************

The objective is to fit a theoretical spectrum shape, which takes the form of a Lorentzian to a point cloud.

In theory
==========

The Lorentzian is defined by :

.. math::
    :label: F(w)

    F(\omega) = \frac{S}{\pi} * \frac{\gamma}{(\omega-\omega_m)^2 + \gamma^2}

Where:math:`\omega` is the emission frequency; :math:`\omega_m` is the "average" frequency, corresponding to the centre of the Lorentzian; :math:`S = \int_{-\infty}^{\infty} F(\omega) d\omega` is the total area under the spectrum curve (equivalent to the total energy); :math:`\gamma` is the broadening coefficient of the gas under consideration.

In order to perform this theoretical fit, we need to transform this function so that it takes the form of a polynomial. We therefore take its inverse:

.. math::
    :label: F(w)-1

    F(\omega)^{-1} &= \frac{\pi}{S} \frac{(\omega-\omega_m)^2 + \gamma^2}{\gamma}

    & = \frac{\pi}{S\gamma}\omega^2 - \frac{2\pi\omega_m}{S\gamma}\omega + \frac{\pi(\omega_m^2 + \gamma^2)}{S\gamma}

For the program, the values of omega are likely to be too large. We then define :

.. math::
    :label: x

    x &= \frac{\omega - \bar{\omega}}{\sqrt{\overline{\omega^2} - \bar{\omega}^2}}

    & \equiv \frac{\omega - \bar{\omega}}{\sigma}
    
This gives us :

.. math::
    :label: F(x)-1

    F(\omega)^{-1} = \frac{\pi\gamma^2}{S\gamma}x^2 + \frac{2\pi\sigma}{S\gamma}(\bar{\omega}-\omega_m)x + \frac{\pi}{S\gamma}(\gamma^2 + (\bar{\omega} - \omega_m)^2)

Which can be rewritten as:

.. math::
    :label: y(x)
    
    F(\omega)^{-1} = a_2x^2 + a_1x + a_0

The objective is to find the combination :math:`{a_0, a_1, a_2}` so as to minimize the coefficients

.. math::
    :label: E

    E(a_0,a_1,a_2) = \sum_{i=1}^{N} W_i (a_2 x_i^2 + a_1 x_i + a_0 - y_i)^2

To find a minimum, we therefore look for the points where the derivative cancels, which gives us:

.. math::

    \begin{cases}
        E_{a_0}' &= 0 \\
        E_{a_1}' &= 0 \\
        E_{a_2}' &= 0
    \end{cases}
    \rightarrow
    \begin{cases}
        \sum_{i=1}^N W_i 2(a_2 x_i^2 + a_1 x_i + a_0 - y_i) &= 0 \\
        \sum_{i=1}^N W_i 2(a_2 x_i^2 + a_1 x_i + a_0 - y_i) x_i &= 0 \\
        \sum_{i=1}^N W_i 2(a_2 x_i^2 + a_1 x_i + a_0 - y_i) x_i^2 &= 0
    \end{cases}


Which when decomposed gives us:

.. math::
    
    \begin{equation}
        \begin{cases}
            a_2 \sum_{i=1}^N W_i x_i^2 + a_1 \sum_{i=1}^N W_i x_i + a_0 \sum_{i=1}^N W_i &= \sum_{i=1}^N W_i y_i \\
            a_2 \sum_{i=1}^N W_i x_i^3 + a_1 \sum_{i=1}^N W_i x_i^2 + a_0 \sum_{i=1}^N W_i x_i &= \sum_{i=1}^N W_i y_i x_i \\
            a_2 \sum_{i=1}^N W_i x_i^4 + a_1 \sum_{i=1}^N W_i x_i^3 + a_0 \sum_{i=1}^N W_i x_i^2 &= \sum_{i=1}^N W_i y_i x_i^2 \\
        \end{cases}\,
    \end{equation}


If we divide everything by :math:`N`, we get the average of all terms:

.. math::

    \begin{equation}
        \begin{cases}
            a_2 \langle W \rangle \langle x^2 \rangle &+ a_1 \langle W \rangle \langle x \rangle   &+ a_0 \langle W \rangle       &= \langle W \rangle \langle y \rangle \\
            a_2 \langle W \rangle \langle x^3 \rangle &+ a_1 \langle W \rangle \langle x^2 \rangle &+ a_0 \langle W \rangle \langle x \rangle   &= \langle W \rangle \langle y x \rangle \\
            a_2 \langle W \rangle \langle x^4 \rangle &+ a_1 \langle W \rangle \langle x^3 \rangle &+ a_0 \langle W \rangle \langle x^2 \rangle &= \langle W \rangle \langle y x^2 \rangle \\
        \end{cases}\,
    \end{equation}


Thus, we can divide everything by :math:`\langle W \rangle` and write this system as a matrix equation:

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


So we can determine the coefficients :math:`a_0, a_1, a_2`

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

Once these coefficients have been calculated, the values of :math:`S`, :math:``gamma` and :math:``bar{\omega}` can be found. Their expression can be recovered from the equations :eq:`F(x)-1` and :eq:`y(x)`

.. math::
    :label: wm

    \bar{\omega} = \langle w \rangle - \sigma \frac{a_1}{2 a_2}

.. math::
    :label: gamma

    \gamma = \sigma \sqrt{\frac{a_0}{a_2} - \frac{a_1^2}{4 a_2^2}}

.. math::
    :label: S

    S = \frac{pi \sigma}{\sqrt{a_0 a_2} - \frac{a_1^2}{4}}

With these 3 parameters, we then have a complete description of :math:`F(\omega)` as initially described in the equation :eq:`F(w)`

In practice
===========

The program reads a file containing on each line a value of :math:`F(\omega)`. We know that these values are given for a :math:`\omega` starting at 2280 and each line increments :math:`\omega` by 0.01.

With this information, we have the coordinates of each point. However, we want to invert the coordinate :math:`y` because we are interested in :math:`F(\omega)^{-1}` in order to have a function in the form of a polynomial.

Also, we calculate for each value of :math:`\omega`, the associated value of :math:`x`.

At this point, we have a new set of coordinates that can be exploited. We then calculate the average values of the different elements (:math:`x`, :math:`y` but also their square etc.). The calculation of this average is done via a dedicated routine.

Once this is done, we can now calculate the coefficients :math:`a_0`, :math:`a_1` and :math:`a_2`. 

From this we can calculate the values of :math:`\bar{\omega}`, :math:`\gamma` and :math:`S`.

Using the first spectrum corresponding to a pressure of 1 atm, we obtain the following result:

.. figure:: https://vincent.foriel.xyz/wp-content/uploads/2021/11/bokeh_plot-1.png

However, we notice that the curve we obtain does not totally coincide with our initial data. Indeed, here, we have given an equal weight to each of the experimental values. However, the high values are more significant than the low values because the noise becomes relatively negligible. So, to avoid trying to adjust the curve to the ambient noise, and thus having this kind of error, we give a weight proportional to the squared intensity of each measurement.

In this way, we obtain the following result:

.. figure:: https://vincent.foriel.xyz/wp-content/uploads/2021/11/bokeh_plot-2.png

The operation can be repeated for the other spectra, thus for other pressures, which gives us:

.. figure:: https://vincent.foriel.xyz/wp-content/uploads/2021/11/bokeh_plot-4.png
