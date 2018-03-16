from IPython.core.display import display, Markdown
import pandas

# utility function for tables

def display_table_pandas(rows):
    header = rows[0]
    body = rows[1:]
    indexes = []
    for row in body:
        indexes += [ row[0] ]

    df = pandas.DataFrame(index=indexes, columns=header[1:])
    for row in body:
        values = row[1:]
        df.loc[row[0]] = values
    print(df)

def display_table(rows, header, title=""):
    table_str = "|"

    for col in header:
        table_str += str(col) + "|"
    table_str += "\n"

    table_str += "|"
    for col in header:
        table_str += "--|"
    table_str += "\n"

    for row in rows:
        table_str += "|"
        for col in row:
            table_str += str(col) + "|"
        table_str += "\n"

    if title:
        table_str += "\nTable: " + title + "\n"

    display(Markdown(table_str))
