import datetime


def read_from_file(file_name):
    """ Function that reads from a text file.

    Args:
        file_name (str): The name of the file.

    Returns: file content as a list
    """
    with open(file_name) as file:
        content_list = file.read().splitlines()

    return content_list


def write_to_file(file_name, data_to_write, restaurant_names, on_date=datetime.date.today()):
    """ Function that writes data to a text file.

    Args:
        file_name (str): The name of the file.

        data_to_write (list): data to be written in new file

        restaurant_names (list): to be used as subtitles

        on_date (str): date time

    """
    with open(file_name, "w") as file:
        file.write(str(on_date))
        file.write('\n\n')
        for item in range(len(restaurant_names)):
            file.write((restaurant_names[item]).upper())
            file.write('\n')
            file.write(data_to_write[item])
            file.write('\n\n')
        file.close()
