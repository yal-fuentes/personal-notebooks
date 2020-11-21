# Stan folder

This folder contains notebooks that use Stan directly or indirectly. For more information please visit:

- Stan Modeling Language Users Guide and Reference Manual. https://mc-stan.org
- Pystan documentation. https://pystan.readthedocs.org

# Getting started

Stan requires C++ compilers to be available for Python. To manage the compilers and environments easily, I personally suggest to install [Miniconda](https://docs.conda.io/en/latest/miniconda.html).

After installing Miniconda, save locally the files in this folder. Open your terminal, go to this folder and run:

```
 conda create --name <selected name for your environment> --file "stan-package-list.txt"
```
Alternatively take `stan-package-list.txt` to your chosen folder and run the previous command. This file makes sure that all the packages dependencies are handled to be able to run the notebooks.

# Stan code

Stan code used inside the notebooks is in `./stan_code`. Make sure to mantain the same folder structure to be able to run the notebooks in your local machine.

# Notebooks

- [Income vs emmisions](./Income_vs_emmisions.ipynb): Notebook that analyses and models the relation between income and CO2 emmisions per capita, for different countries. Analysis implements step by step Bayesian workflow.

# Additional information

For OSX users, currently there seems to be an issue with PyStan and command line tools for XCode 12. I'm using command line tools for XCode 11.5 to avoid this problem.

- More information about the issue: [Pystan issue 622](https://github.com/stan-dev/pystan/issues/622)
- More information about command line tools for Xcode: https://developer.apple.com/downloads/index.action. Requires Apple ID.
