import datalogy

from setuptools import setup

setup(
    name=datalogy.__name__,
    version=datalogy.__version__,
    description=datalogy.__doc__,
    url=datalogy.__url__,
    packages=['datalogy'],
    install_requires=[
        'cssselect < 1.0.0',
        'lxml < 4.0.0',
    ],
    entry_points={
        'console_scripts': [
            'scrape = datalogy.scrape:main',
            'random-sample = datalogy.sample:main',
        ],
    },
)
