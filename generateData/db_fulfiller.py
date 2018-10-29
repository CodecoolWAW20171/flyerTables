import psycopg2
import psycopg2.extras

from generateData import db_connection


def csv_to_list_of_tuples(file_name, elem_to_del=[], split_char=","):  #[]- indexes of elements to remove from row, asc
    with open(file_name, "r") as file:
        lines = file.readlines()
    tuples_in_table = [element.replace("'", '').replace("\n", "").replace(", ", " ").split(split_char) for element in lines]
    for i in range(len(tuples_in_table)):
        if len(elem_to_del) > 0:
            for d in reversed(elem_to_del):
                del tuples_in_table[i][d]
        tuples_in_table[i] = tuple(tuples_in_table[i])
    print("Table to insert prepared")
    return tuples_in_table


# file_name - path to source csv file; db_table_name - table in DB where you want to insert records;
# column_numbers_to_delete_from_csv - asc ordered list of numbers of column (in csv) where you dont wanna insert into;
# column_names_tuple - names of column in DB table where you wanna add values;
@db_connection.connection_handler
def fulfill_db(cursor, file_name, db_table_name, column_numbers_to_delete_from_csv=[], column_names_tuple=(), split_char=","):
    source_table_of_tuples = csv_to_list_of_tuples(file_name, column_numbers_to_delete_from_csv, split_char)
    print("inserting... (expected speed: ~100 rows per second)")

    if len(source_table_of_tuples[0]) == 0:
        for values in source_table_of_tuples:
            cursor.execute("""
                            INSERT INTO {table}
                            VALUES {values};
                           """.format(table=db_table_name, values=values))
    elif len(source_table_of_tuples[0]) == 1:
        tab_cols = db_table_name + '(' + column_names_tuple + ')'
        for values in source_table_of_tuples:
            values = "(" + values[0] + ")"
            cursor.execute("""
                            INSERT INTO {tab_and_cols}
                            VALUES {values};
                           """.format(tab_and_cols=tab_cols, values=values))
    else:
        tab_cols = db_table_name + '(' + ",".join(column_names_tuple) + ')'
        for values in source_table_of_tuples:
            cursor.execute("""
                                    INSERT INTO {tab_and_cols}
                                    VALUES {values};
                                   """.format(tab_and_cols=tab_cols, values=values))
    print("Done :)")

####################### Execute:  #####################################

fulfill_db("/home/mariusz/PycharmProjects/flyerTables/csv_files/crew.csv",
           "crew",
           [0],
           ("first_name", "last_name", "function"))

