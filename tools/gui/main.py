import dearpygui.dearpygui as dpg

WINDOW_WIDTH = 900
WINDOW_HEIGHT = 600
MAIN_MENU_BAR_HEIGHT = 30

DEFAULT_FONT_SIZE = 25
DEFAULT_GUI_FONT = "tools/gui/fonts/SourceSans3-Regular.otf"
CODE_FONT = "tools/gui/fonts/SourceCodePro-Regular.otf"
DEFAULT_FILES_PATH = "test"

FILE_NOT_FOUND_POPUP = "file_not_found"
INPUT_CODE_VALUE = "code_to_check"


# Test function
def callback(sender, app_data, user_data):
    print(f"sender is: {sender}")
    print(f"app_data is: {app_data}")
    print(f"user_data is: {user_data}")


def load_code_from_file(_, app_data):
    file = app_data["file_path_name"]
    try:
        with open(file, "r", encoding="utf-8") as f:
            dpg.set_value(INPUT_CODE_VALUE, f.read())
    except FileNotFoundError:
        dpg.configure_item(FILE_NOT_FOUND_POPUP, show=True)


def select_file_dialog():
    with dpg.file_dialog(
        show=False,
        modal=True,
        callback=load_code_from_file,
        width=int(WINDOW_WIDTH * 0.7),
        height=int(WINDOW_HEIGHT * 0.7),
        default_path=DEFAULT_FILES_PATH,
        default_filename="",
    ) as dialog:
        color = (150, 211, 131)
        dpg.add_file_extension(".txt", color=color)
        dpg.add_file_extension(".mylang", color=color)

    return dialog


def setup_main_menu_bar():
    file_dialog = select_file_dialog()

    with dpg.viewport_menu_bar():
        with dpg.menu(label="File"):
            dpg.add_menu_item(
                label="Open File",
                callback=lambda: dpg.show_item(file_dialog),
            )

        with dpg.menu(label="Check"):
            dpg.add_menu_item(label="Tokens", callback=callback)
            dpg.add_menu_item(label="Syntax", callback=callback)


def setup_windows():
    with dpg.font_registry():
        default_font = dpg.add_font(DEFAULT_GUI_FONT, DEFAULT_FONT_SIZE)
        code_font = dpg.add_font(CODE_FONT, int(DEFAULT_FONT_SIZE * 0.7))

    setup_main_menu_bar()

    with dpg.window(
        modal=True,
        show=False,
        tag=FILE_NOT_FOUND_POPUP,
        no_title_bar=True,
        no_resize=True,
    ):
        dpg.add_text("File not found.")
        dpg.add_separator()
        with dpg.group(horizontal=True):
            dpg.add_button(
                label="OK",
                width=75,
                callback=lambda: dpg.configure_item(FILE_NOT_FOUND_POPUP, show=False),
            )

    with dpg.window(
        width=WINDOW_WIDTH,
        height=WINDOW_HEIGHT - MAIN_MENU_BAR_HEIGHT,
        pos=(0, MAIN_MENU_BAR_HEIGHT),
        no_resize=True,
        no_move=True,
        no_close=True,
        no_title_bar=True,
    ):
        text_box = dpg.add_text(
            label="code",
            tag=INPUT_CODE_VALUE,
            default_value="# Write your code here...",
        )
        dpg.bind_item_font(text_box, code_font)

    dpg.bind_font(default_font)


def main():
    dpg.create_context()
    dpg.create_viewport(
        width=WINDOW_WIDTH,
        height=WINDOW_HEIGHT,
        resizable=False,
    )

    setup_windows()

    dpg.setup_dearpygui()
    dpg.show_viewport()
    dpg.start_dearpygui()
    dpg.destroy_context()


if __name__ == "__main__":
    main()
