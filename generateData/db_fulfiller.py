import psycopg2
import psycopg2.extras

from generateData import db_connection


def csv_to_list_of_tuples(file_name, elem_to_del=[], split_char=","):  #[]- indexes of elements to remove from row, asc
    with open(file_name, "r") as file:
        lines = file.readlines()
    tuples_in_table = [element.replace("\n", "").split(split_char) for element in lines]
    for i in range(len(tuples_in_table)):
        if len(elem_to_del) > 0:
            for d in reversed(elem_to_del):
                del tuples_in_table[i][d]

        tuples_in_table[i] = tuple(tuples_in_table[i])
    return tuples_in_table


@db_connection.connection_handler
def fulfill_db(cursor, db_table_name, source_table_of_tuples, column_names_tuple=()):
    for values in source_table_of_tuples:
        if len(column_names_tuple) > 0:
            tab_cols = db_table_name + '(' + ",".join(column_names_tuple) + ')'
            cursor.execute("""
                            INSERT INTO {tab_and_cols}
                            VALUES {values};
                           """.format(tab_and_cols=tab_cols, values=values))
        else:
            cursor.execute("""
                            INSERT INTO {table}
                            VALUES {values};
                           """.format(table=db_table_name, values=values))


t = csv_to_list_of_tuples("test_inventory.csv", [0])
fulfill_db('schools', t, ('name', 'city', 'country', 'contact_person'))