#!/usr/bin/env python3
import json
import uuid
import os
import argparse
import sys


def update_json_file(file_path, keys, value):
    if not os.path.exists(file_path):
        print(f"File '{file_path}' does not exist. Exiting the program.")
        sys.exit()

    with open(file_path, "r", encoding="utf-8") as f:
        data = json.load(f)

    d = data
    for key in keys[:-1]:
        d = d[key]
    d[keys[-1]] = value

    tempfile = os.path.join(os.path.dirname(file_path), str(uuid.uuid4()))
    with open(tempfile, "w", encoding="utf-8") as f:
        json.dump(data, f, indent=4)
        os.replace(tempfile, file_path)


def main():
    parser = argparse.ArgumentParser("json_edit")
    parser.add_argument("path", help="Path to the json file", type=str)
    parser.add_argument("keys", help="String in the format 'key1.key2'", type=str)
    parser.add_argument("value", help="Value to set the keys to", type=str)
    args = parser.parse_args()

    keys = args.keys.split(".")
    path = args.path
    value = args.value

    update_json_file(path, keys, value)


if __name__ == "__main__":
    main()
