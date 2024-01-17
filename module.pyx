# relative path from ./build
cdef extern from "../src/add.c":
    double f(double a, double b)

def add(double a, double b):
    return f(a, b)