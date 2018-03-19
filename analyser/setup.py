#!/usr/bin/env python3

from setuptools import setup, find_packages

setup(
        name="SSBM Hana Analyser",
        version="0.0.1",
        packages=find_packages(),
        scripts=["analyse.py"],
        install_requires=[
            "numpy",
            "terminaltables",
            "jupyter",
            "matplotlib",
            "nbconvert",
            "pandas"
        ],
        author="Arwed Mett"
)
