n = eval(input("Input Sierpinski triangle order (recommended: 6)"))

def zero_arr(n):
    """
    generates a gen n zero array
    used for sierpinski function
    """
    size = 2 ** n
    return [[0] * size] * size

def beside(arr1, arr2, size):
    """
    concatenates 2d arrays side by side
    used for sierpinski function
    """
    arr = [0] * size
    for i in range(size):
        arr[i] = arr1[i] + arr2[i]    
    return arr

def sierpinski(n):
    """
    generates set of moves for table solving of 2 ** n coins including n = 16, n = 32 etc
    moves form a sierpinski triangle fractal
    """
    if n <= 0:  # invalid case
        return 
    if n == 1:  # base case
        return [[1, 1], [1, 0]]
    partial_sierpinski = sierpinski(n - 1) # generate lower gen sierpinski
    array_zeros = zero_arr(n - 1)
    
    size = 2 ** (n - 1)
    # recursion
    return beside(partial_sierpinski, partial_sierpinski, size) + beside(partial_sierpinski, array_zeros, size)
    
if type(n) == int:
    lines = sierpinski(n)
    arr = [0] * 2 ** n
    index = 0
    for item in lines:
        string_item = [str("X"*i + " "*(1 - i)) for i in item]
        arr[index] = "".join(string_item) + "\n"
        index = index + 1
    print("".join(arr))
