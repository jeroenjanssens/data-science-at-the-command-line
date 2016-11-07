#!/usr/bin/env python3

import argparse
import csv
from sys import stdin, stdout, stderr, exit
import itertools


def main():
    parser = argparse.ArgumentParser(
        epilog="""If both --classes and --auto-relabel are omitted,
        label values are left as-is. By default, features with value 0 are not
        printed. This can be overridden with --null""",
        usage="""%(prog)s [OPTION]... [FILE]

Convert CSV to Vowpal Wabbit input format.

  Examples:

  # Leave label values as is:
  $ csv2vw spam.csv --label target

  # Relabel values 'ham' to 0 and 'spam' to 1:
  $ csv2vw spam.csv --label target --classes ham,spam

  # Relabel values 'ham' to -1 and 'spam' to +1 (needed for logistic loss):
  $ csv2vw spam.csv --label target --classes ham,spam --minus-plus-one

  # Relabel first label value to 0, second to 1, and ignore the rest:
  $ csv2vw iris.csv -lspecies --auto-relabel --ignore-extra-classes

  # Relabel first label value to 1, second to 2, and so on:
  $ <iris.csv csv2vw -lspecies --multiclass --auto-relabel

  # Relabel 'versicolor' to 1, 'virginica' to 2, and 'setosa' to 3
  $ <iris.csv csv2vw -lspecies --multiclass -cversicolor,virginica,setosa""")

    parser.add_argument("file", nargs="?", type=argparse.FileType("r"),
                        default=stdin,
                        help="""Input CSV file. If omitted,
                        read from standard input.""",
                        metavar="FILE")
    parser.add_argument("-d", "--delimiter",
                        help="""Delimiting character of the input CSV file
                        (default: ,).""",
                        default=",")
    parser.add_argument("-l", "--label",
                        help="""Name of column that contains the class
                        labels.""")
    parser.add_argument("-c", "--classes",
                        help="""Ordered, comma-separated list of possible
                        class labels to relabel. If not specifying all possible
                        class labels, use --auto-relabel.""",
                        nargs="?")
    parser.add_argument("-n", "--null",
                        help="""Comma-separated list of null values (default:
                        '0').""",
                        nargs="?", default="0")
    parser.add_argument("-a", "--auto-relabel",
                        help="""Automatically relabel class labels in the order
                        in which they appear in the CSV file.""",
                        action="store_true")
    parser.add_argument("-m", "--multiclass",
                        help="""Indicates more than two classes; will start
                        counting at 1 instead of 0.""",
                        action="store_true")
    parser.add_argument("-+", "--minus-plus-one",
                        help="""Instead of relabeling to integers, relabel to
                        '-1' and '+1'. Needed when using VW with logistic or
                        hinge loss.""", action="store_true")
    parser.add_argument("-i", "--ignore-extra-classes",
                        help="""If there are more than two classes found, when
                        not using --multiclass, include the example with no
                        label instead of giving skipping it.""",
                        action="store_true")
    parser.add_argument("-t", "--tag",
                        help="""Name of column that contains the tags.""")

    args = parser.parse_args()

    auto_relabel = args.auto_relabel
    label_column = args.label
    tag_column = args.tag
    null_values = args.null.split(",")
    multiclass = args.multiclass
    minus_plus_one = args.minus_plus_one

    if minus_plus_one:
        new_classes = iter(["-1", "+1"])
    elif multiclass:
        new_classes = (str(i) for i in itertools.count(1))
    elif args.classes or auto_relabel:
        new_classes = iter(["0", "1"])
    else:
        new_classes = None

    if args.classes:
        old_classes = args.classes.split(",")
        relabel = dict(zip(old_classes, new_classes))
    else:
        relabel = dict()

    reader = csv.DictReader(args.file, delimiter=args.delimiter)
    try:
        for row in reader:
            label = row.pop(label_column, "")
            tag = row.pop(tag_column, "")

            if auto_relabel or new_classes:
                if auto_relabel:
                    if label not in relabel:
                        try:
                            relabel[label] = next(new_classes)
                        except StopIteration:
                            if args.ignore_extra_classes:
                                relabel[label] = ""
                            else:
                                stderr.write("Found too many different classes;"
                                             " skipping example. Use "
                                             "--multiclass or "
                                             "--ignore-extra-classes.\n")
                                continue
                label = relabel[label]

            features = " ".join([k + ":" + v for k, v in sorted(row.items())
                                 if v not in null_values])
            line = label + " " + tag + "| " + features + "\n"
            stdout.write(line)
            stdout.flush()
    except (IOError, KeyboardInterrupt, BrokenPipeError):
        stderr.close()

if __name__ == "__main__":
    exit(main())
