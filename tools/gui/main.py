import os
import subprocess
from pathlib import Path
from typing import Literal

import dearpygui.dearpygui as dpg

WINDOW_WIDTH = 900
WINDOW_HEIGHT = 600
MAIN_MENU_BAR_HEIGHT = 30

DEFAULT_FONT_SIZE = 25
DEFAULT_GUI_FONT = "tools/gui/fonts/SourceSans3-Regular.otf"
CODE_FONT = "tools/gui/fonts/SourceCodePro-Regular.otf"
DEFAULT_FILES_PATH = "test"

PRIMARY_WINDOW_TAG = "primary_window"
FILE_NOT_FOUND_POPUP = "file_not_found"
ANALYSIS_RESULT_POPUP = "results_popup"
ANALYSIS_RESULT_VALUE = "results_value"
INPUT_CODE_VALUE = "code_to_check"

CODE_EXAMPLE = """\
# Write your code here...

def main: int () {
    print("Hello world");
    return 0;
}
"""


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


def get_java_classes() -> str:
    jars = (path for path in Path("lib").iterdir())
    bin = Path("bin")
    classes = (path.absolute() for path in (bin, *jars))
    classes = (str(path) for path in classes)
    return ":".join(classes)


def check_code(option: Literal["lexer", "parser"]):
    path_to_tmp_file = Path("tools/gui/.tmp")
    java_classes = get_java_classes()
    analyzer_args = [
        "java",
        "--class-path",
        java_classes,
        "Main",
        option,
        str(path_to_tmp_file),
    ]
    code_to_check = dpg.get_value(INPUT_CODE_VALUE)

    try:
        with open(path_to_tmp_file, "w", encoding="utf-8") as tmp_file:
            tmp_file.write(code_to_check)

        analyzer = subprocess.run(
            analyzer_args,
            capture_output=True,
            universal_newlines=True,
        )
    finally:
        os.remove(path_to_tmp_file)

    result = analyzer.stdout.strip() or analyzer.stderr.strip()
    dpg.set_value(ANALYSIS_RESULT_VALUE, result)
    dpg.configure_item(ANALYSIS_RESULT_POPUP, show=True)


def setup_main_menu_bar():
    file_dialog = select_file_dialog()

    with dpg.viewport_menu_bar():
        with dpg.menu(label="File"):
            dpg.add_menu_item(
                label="Open File",
                callback=lambda: dpg.show_item(file_dialog),
            )

        with dpg.menu(label="Analyze"):
            dpg.add_menu_item(label="Tokens", tag="lexer", callback=check_code)
            with dpg.tooltip(dpg.last_item()):
                dpg.add_text("Lexer")
            dpg.add_menu_item(label="Syntax", tag="parser", callback=check_code)
            with dpg.tooltip(dpg.last_item()):
                dpg.add_text("Parser")


def setup_windows():
    with dpg.font_registry():
        default_font = dpg.add_font(DEFAULT_GUI_FONT, DEFAULT_FONT_SIZE)
        code_font = dpg.add_font(CODE_FONT, int(DEFAULT_FONT_SIZE * 0.8))

    setup_main_menu_bar()

    # Popup for a file not found error
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

    # Popup for the analysis result
    with dpg.window(
        label="Results",
        modal=True,
        show=False,
        tag=ANALYSIS_RESULT_POPUP,
        no_close=True,
    ):
        text_box = dpg.add_text("", tag=ANALYSIS_RESULT_VALUE, color=(115, 157, 243))
        dpg.bind_item_font(text_box, code_font)
        dpg.add_separator()
        with dpg.group(horizontal=True):
            dpg.add_button(
                label="OK",
                width=75,
                callback=lambda: dpg.configure_item(ANALYSIS_RESULT_POPUP, show=False),
            )

    with dpg.window(tag=PRIMARY_WINDOW_TAG):
        padding = 10
        text_box = dpg.add_input_text(
            tag=INPUT_CODE_VALUE,
            pos=(padding, MAIN_MENU_BAR_HEIGHT + padding),
            width=WINDOW_WIDTH - padding * 2,
            height=WINDOW_HEIGHT - padding * 5,
            default_value=CODE_EXAMPLE,
            multiline=True,
            tab_input=True,
        )
        dpg.bind_item_font(text_box, code_font)

    dpg.bind_font(default_font)


def main():
    dpg.create_context()
    setup_windows()

    dpg.create_viewport(width=WINDOW_WIDTH, height=WINDOW_HEIGHT, resizable=False)
    dpg.setup_dearpygui()
    dpg.show_viewport()
    dpg.set_primary_window(PRIMARY_WINDOW_TAG, True)
    dpg.start_dearpygui()
    dpg.destroy_context()


if __name__ == "__main__":
    main()
