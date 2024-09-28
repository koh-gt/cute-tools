def print_info():
    print("""
    Boolean to Truth Table generator by koh-gt
    2024 09 28
          
    PLEASE CHECK >> NOR OPERATORS ARE UNSUPPORTED <<
    
    USE de Morgan's Law please -> 
        A NOR B
    ->  NOT (A OR B)
          
    Boolean operators supported:
    Simple: AND, OR, XOR, NOT
    Compound: XNOR, NAND
    """)

def get_expression():    
    expression = input("Input your Boolean expression: \n")
    return expression


def filter_expression(expression=""):
    expression = expression.lower()
    
    expression = expression.replace("xnor","==")
    expression = expression.replace("xor not","==")
    expression = expression.replace("nand","&~")

    expression = expression.replace("and","&")
    expression = expression.replace("xor","^")
    expression = expression.replace("or","|") # replace xor before or
    expression = expression.replace("not","~").replace("!","~")
    return expression
    
def filter_alphanumeric(string_input):
    alphanumeric = set('0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz')
    return list(filter(alphanumeric.__contains__, string_input))

def get_variables(expression=""):
    return filter_alphanumeric(expression)  # filter from symbols

def initialise_table_input_list(variable_count=0):

    def generate_binary_numbers(bits):
        n = [(bin(i)[2:]).zfill(bits) for i in range(2 ** bits)]
        return n

    table_bin = generate_binary_numbers(variable_count)
    table = [list(i) for i in table_bin]
    return table

def evaluate_array_expression(expression, array_input=[], variables=[]):
    new_expression = expression
    for i in range(len(variables)):
        new_expression = new_expression.replace(variables[i], array_input[i])
    return str(eval(new_expression))

def generate_table_list(expression="", table_input=[], variables=[]):
    dimension = len(table_input[0])
    return [array_input + [evaluate_array_expression(expression, array_input, variables)] for array_input in table_input]

def output_table_line(table_line=[]):
    return "| " + " | ".join(table_line) + "\n"

def output_table_separator(variables=[], expression=""):
    return "|" + "---|" * len(variables) + "-" * len(expression) + "--|\n"

def output_table(table=[], variables=[], expression=""):
    number_of_lines = len(table)
    output = ["" for i in range(number_of_lines)]
    for i in range(number_of_lines):
        output[i] = output_table_line(table[i])
    print(output_table_line(variables + [f"{expression}"]) + output_table_separator(variables, expression) + "".join(output))

def main():
    print_info()
    expression = filter_expression(get_expression())
    print(expression)
    variables = get_variables(expression)
    init_table = initialise_table_input_list(len(variables))
    generated_table = generate_table_list(expression, init_table, variables)
    output_table(generated_table, variables, expression)

main()
