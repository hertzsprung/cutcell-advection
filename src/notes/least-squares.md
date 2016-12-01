John asked how we can perform a least squares fit using only the mesh geometry and without knowing the phi data.  Let's take a linear fit through some point data in order to approximate the value at the y-intercept, `a_1`,

    phi = a_1 + a_2 x

Let phi = [1, 3, 6] at positions [-1, 2, 5].  So, without using the phi values, we can write

    phi_1 = a_1 + a_2 * -1
    phi_2 = a_1 + a_2 * 2
    phi_3 = a_1 + a_2 * 5

or, in matrix form,

            [ 1 -1 ]
    phi = a [ 1  2 ]
            [ 1  5 ]

            \______/
	           = B

We can solve the equation in a least-squares sense using the pseudo-inverse `B+`:

    a = B+ phi

such that the y-intercept, `a_1`, is the dot product of the first row of `B+` and the phi vector.

In this way, we can perform a least-squares fit where the majority of calculations are performed without the knowledge of the phi values.  Of course, the y-intercept, `a_1`, and slope, `a_2`, cannot be calculated without knowing the phi values.
