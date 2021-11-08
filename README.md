Fitting Spectra - Projet report
===============

Vincent Foriel - 07/11/2021

Guide d\'utilisation
====================

Dépendences
-----------

-   Fortran 90
-   Python 3.9 & pip

Installation
------------

1)  Placez vous dans le dossier de votre choix, puis clonez le
    répertoire git via la commande :

``` {.sourceCode .}
git clone https://gitlab.com/LeiRoF/fitting-spectra
```

2)  Déplacez vous dans le dossier du projet

``` {.sourceCode .}
cd fitting-spectra/
```

3)  Installez les dépendances du program Python permettant l\'affichage
    des résultats sous la forme d\'un graphique

``` {.sourceCode .}
pip install -r ./requirements.txt
```

4)  En utilisant [GFortran](https://gcc.gnu.org/wiki/GFortran), compilez
    les fichiers fortran

``` {.sourceCode .}
gfortran -o fit_spectra ./fit_spectra.f90
gfortran -o fit_omega ./fit_omega.f90
```

Utilisation
-----------

Ce projet contient 2 programmes indépendants :

-   Fit Spectra a pour but de déterminer une fonction lorentzienne à
    partir d\'un ensemble de points donnés via un fichier dans
    [./data/]{.title-ref}
-   Fit Omega permet ensuite de faire une régression linéaire, ce qui
    permet, dans le contexte de ce projet, de déterminer l\'énergie
    fondamentale de rotation du gaz.

Vous pouvez éditez les fichiers [fit\_spectra.f90]{.title-ref} et
[fit\_omega.f90]{.title-ref} afin d\'y modifier le fichier considéré.
Une fois édité, ré-effectuez l\'étape 3 de l\'installation (compilation
des fichiers Fortran)

Lancer Fit Spectra

``` {.sourceCode .}
./fit_spectra
```

Lancer Fit Omega

``` {.sourceCode .}
./fit_omega
```

> Si une erreur apparait à la fin de l\'execution du programme et
qu\'aucune fenêtre ne s\'affiche, vous pouvez l\'ouvrir manuellement en
utilisant votre navigateur pour ouvrir le fichier
`plot\_spectra.hmtl` ou `plot\_omega.html`

Adjustment of a Lorentzian
==========================

The objective is to fit a theoretical spectrum shape, which takes the
form of a Lorentzian to a point cloud.

In theory
---------

The Lorentzian is defined by :

$$F(\omega) = \frac{S}{\pi} * \frac{\gamma}{(\omega-\omega_m)^2 + \gamma^2}$$

Where$\omega$ is the emission frequency; $\omega_m$ is the \"average\"
frequency, corresponding to the centre of the Lorentzian;
$S = \int_{-\infty}^{\infty} F(\omega) d\omega$ is the total area under
the spectrum curve (equivalent to the total energy); $\gamma$ is the
broadening coefficient of the gas under consideration.

In order to perform this theoretical fit, we need to transform this
function so that it takes the form of a polynomial. We therefore take
its inverse:

$$F(\omega)^{-1} = \frac{\pi}{S} \frac{(\omega-\omega_m)^2 + \gamma^2}{\gamma}$$

$$= \frac{\pi}{S\gamma}\omega^2 - \frac{2\pi\omega_m}{S\gamma}\omega + \frac{\pi(\omega_m^2 + \gamma^2)}{S\gamma}$$

For the program, the values of omega are likely to be too large. We then
define :

$$x = \frac{\omega - \bar{\omega}}{\sqrt{\overline{\omega^2} - \bar{\omega}^2}}$$

$$ \equiv \frac{\omega - \bar{\omega}}{\sigma}$$

This gives us :

$$F(\omega)^{-1} = \frac{\pi\gamma^2}{S\gamma}x^2 + \frac{2\pi\sigma}{S\gamma}(\bar{\omega}-\omega_m)x + \frac{\pi}{S\gamma}(\gamma^2 + (\bar{\omega} - \omega_m)^2)$$

Which can be rewritten as:

$$F(\omega)^{-1} = a_2x^2 + a_1x + a_0$$

The objective is to find the combination ${a_0, a_1, a_2}$ so as to
minimize the coefficients

$$E(a_0,a_1,a_2) = \sum_{i=1}^{N} W_i (a_2 x_i^2 + a_1 x_i + a_0 - y_i)^2$$

To find a minimum, we therefore look for the points where the derivative
cancels, which gives us:

$$\begin{aligned}
\begin{cases}
    E_{a_0}' &= 0 \\
    E_{a_1}' &= 0 \\
    E_{a_2}' &= 0
\end{cases}
\end{aligned}$$

$$\begin{aligned}
\rightarrow
\begin{cases}
\sum_{i=1}^N W_i 2(a_2 x_i^2 + a_1 x_i + a_0 - y_i) &= 0 \\
\sum_{i=1}^N W_i 2(a_2 x_i^2 + a_1 x_i + a_0 - y_i) x_i &= 0 \\
\sum_{i=1}^N W_i 2(a_2 x_i^2 + a_1 x_i + a_0 - y_i) x_i^2 &= 0
\end{cases}
\end{aligned}$$

Which when decomposed gives us:

$$\begin{aligned}
\begin{cases}
    a_2 \sum_{i=1}^N W_i x_i^2 + a_1 \sum_{i=1}^N W_i x_i + a_0 \sum_{i=1}^N W_i \\
    a_2 \sum_{i=1}^N W_i x_i^3 + a_1 \sum_{i=1}^N W_i x_i^2 + a_0 \sum_{i=1}^N W_i x_i \\
    a_2 \sum_{i=1}^N W_i x_i^4 + a_1 \sum_{i=1}^N W_i x_i^3 + a_0 \sum_{i=1}^N W_i x_i^2
\end{cases}
\end{aligned}$$

$$\begin{aligned}
=
\begin{cases}
    \sum_{i=1}^N W_i y_i \\
    \sum_{i=1}^N W_i y_i x_i \\
    \sum_{i=1}^N W_i y_i x_i^2
\end{cases}
\end{aligned}$$

If we divide everything by $N$, we get the average of all terms:

$$\begin{aligned}
\begin{cases}
    a_2 \langle W \rangle \langle x^2 \rangle &+ a_1 \langle W \rangle \langle x \rangle   &+ a_0 \langle W \rangle \\
    a_2 \langle W \rangle \langle x^3 \rangle &+ a_1 \langle W \rangle \langle x^2 \rangle &+ a_0 \langle W \rangle \langle x \rangle \\
    a_2 \langle W \rangle \langle x^4 \rangle &+ a_1 \langle W \rangle \langle x^3 \rangle &+ a_0 \langle W \rangle \langle x^2 \rangle
\end{cases}
\end{aligned}$$

$$\begin{aligned}
=
\begin{cases}
    \langle W \rangle \langle y \rangle \\
    \langle W \rangle \langle y x \rangle \\
    \langle W \rangle \langle y x^2 \rangle
\end{cases}
\end{aligned}$$

Thus, we can divide everything by $\langle W \rangle$ and write this
system as a matrix equation:

$$\begin{aligned}
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
\end{aligned}$$

So we can determine the coefficients $a_0, a_1, a_2$

$$\begin{aligned}
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
\end{aligned}$$

$$\begin{aligned}
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
\end{aligned}$$

$$\begin{aligned}
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
\end{aligned}$$

Once these coefficients have been calculated, the values of $S$,
$`gamma$ and $`bar{\omega}$ can be found. Their expression can be
recovered from the expressions of $F(x)^{-1}$ and $y(x)$

$$\bar{\omega} = \langle w \rangle - \sigma \frac{a_1}{2 a_2}$$

$$\gamma = \sigma \sqrt{\frac{a_0}{a_2} - \frac{a_1^2}{4 a_2^2}}$$

$$S = \frac{pi \sigma}{\sqrt{a_0 a_2} - \frac{a_1^2}{4}}$$

With these 3 parameters, we then have a complete description of
$F(\omega)$

In practice
-----------

The program reads a file containing on each line a value of $F(\omega)$.
We know that these values are given for a $\omega$ starting at 2280 and
each line increments $\omega$ by 0.01.

With this information, we have the coordinates of each point. However,
we want to invert the coordinate $y$ because we are interested in
$F(\omega)^{-1}$ in order to have a function in the form of a
polynomial.

Also, we calculate for each value of $\omega$, the associated value of
$x$.

At this point, we have a new set of coordinates that can be exploited.
We then calculate the average values of the different elements ($x$, $y$
but also their square etc.). The calculation of this average is done via
a dedicated routine.

Once this is done, we can now calculate the coefficients $a_0$, $a_1$
and $a_2$.

From this we can calculate the values of $\bar{\omega}$, $\gamma$ and
$S$.

Using the first spectrum corresponding to a pressure of 1 atm, we obtain
the following result:

![](https://vincent.foriel.xyz/wp-content/uploads/2021/11/bokeh_plot-1.png)

However, we notice that the curve we obtain does not totally coincide
with our initial data. Indeed, here, we have given an equal weight to
each of the experimental values. However, the high values are more
significant than the low values because the noise becomes relatively
negligible. So, to avoid trying to adjust the curve to the ambient
noise, and thus having this kind of error, we give a weight proportional
to the squared intensity of each measurement.

In this way, we obtain the following result:

![](https://vincent.foriel.xyz/wp-content/uploads/2021/11/bokeh_plot-2.png)

The operation can be repeated for the other spectra, thus for other
pressures, which gives us:

![](https://vincent.foriel.xyz/wp-content/uploads/2021/11/bokeh_plot-4.png)

Linear Regression
=================

In theory
---------

Like the fit for a Lorentzian, the idea here is also to apply the least
squares method. However, we now have a simpler equation:

$$y = a_0 + a_1 x$$

The objective is therefore to find the combination ${a_0, a_1}$ so as to
minimise the following coefficients.

$$E(a_0,a_1) = \sum_{i=1}^{N} W_i (a_1 x_i + a_0 - y_i)^2$$

The rest of the development is therefore very similar to that done to
fit the Lorentzian. To find a minimum, we look for the points where the
derivative cancels, which gives us:

$$\begin{aligned}
\begin{equation}
    \begin{cases}
        E_{a_0}' &= 0 \\
        E_{a_1}' &= 0
    \end{cases}\,\rightarrow
    \begin{cases}
        \sum_{i=1}^N W_i 2(a_1 x_i + a_0 - y_i) &= 0 \\
        \sum_{i=1}^N W_i 2(a_1 x_i + a_0 - y_i) x_i &= 0
    \end{cases}\,
\end{equation}
\end{aligned}$$

Which when decomposed gives us:

$$\begin{aligned}
\begin{equation}
    \begin{cases}
        a_1 \sum_{i=1}^N W_i x_i + a_0 \sum_{i=1}^N W_i &= \sum_{i=1}^N W_i y_i \\
        a_1 \sum_{i=1}^N W_i x_i^2 + a_0 \sum_{i=1}^N W_i x_i &= \sum_{i=1}^N W_i y_i x_i
    \end{cases}\,
\end{equation}
\end{aligned}$$

If we divide everything by $N$, we get the average of all terms:

$$\begin{aligned}
\begin{equation}
    \begin{cases}
        a_1 \langle W \rangle \langle x \rangle &+ a_0 \langle W \rangle &= \langle W \rangle \langle y \rangle \\
        a_1 \langle W \rangle \langle x^2 \rangle &+ a_0 \langle W \rangle \langle x \rangle &= \langle W \rangle \langle y x \rangle
    \end{cases}\,
\end{equation}
\end{aligned}$$

Thus, we can divide everything by $\langle W \rangle$ and write this
system as a matrix equation:

$$\begin{aligned}
\begin{pmatrix}
    1 & \langle x \rangle \\
    \langle x \rangle & \langle x^2 \rangle
\end{pmatrix}.
\begin{pmatrix}
    a_0 \\
    a_1
\end{pmatrix}=
\begin{pmatrix}
    \langle y \rangle \\
    \langle y x \rangle
\end{pmatrix}
\end{aligned}$$

We can therefore determine the coefficients $a_0, a_1$

$$\begin{aligned}
a_0 = \frac{
\begin{vmatrix}
    \langle y \rangle & \langle x \rangle \\
    \langle yx \rangle & \langle x^2 \rangle
\end{vmatrix}
}{
\begin{vmatrix}
    1 & \langle x \rangle \\
    \langle x \rangle & \langle x^2 \rangle 
\end{vmatrix}
}
\end{aligned}$$

$$a_0 = \frac { \langle y \rangle \langle x^2 \rangle - \langle yx \rangle \langle x \rangle }
            { \langle x^2 \rangle - \langle x \rangle }$$

$$\begin{aligned}
a_1 &= \frac{
\begin{vmatrix}
    1 & \langle y \rangle \\
    \langle x \rangle & \langle yx \rangle   
\end{vmatrix}
}{
\begin{vmatrix}
    1 & \langle x \rangle \\
    \langle x \rangle & \langle x^2 \rangle 
\end{vmatrix}
}
\end{aligned}$$

$$a_1 = \frac { \langle yx \rangle - \langle x \rangle \langle y \rangle }
            { \langle x^2 \rangle - \langle x \rangle }$$

In practice
-----------

The program reads a file containing on each line a value of $\omega(P)$.
We know that the values of P are, respectively for each line:
$[1,3,6,10,15]$

Here we do not need to modify the data because the function $\omega(P)$
is already in the form of a polynomial of type $y = a_0 + a_1x$

We then directly calculate the sums of the different elements ($\omega$,
$P$ but also their square etc.). Here, we calculate the sum and not the
average in order to minimise the number of lines of code, but the
principle and the result are the same.

Once this step is done, we can now calculate the coefficients $a_0$,
$a_1$, which give us directly the expression of our line.

We thus obtain a line of expression

$$\omega = 0.145 * P + 2282.498$$

$2282.498$\` thus corresponds to the minimum intensity generated by the
rotation of the gas molecules.

![](https://vincent.foriel.xyz/wp-content/uploads/2021/11/bokeh_plot-7.png)
