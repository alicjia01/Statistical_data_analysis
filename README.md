# Statistical Data Analysis

This repository contains projects completed for the **Statistical Data Analysis** course. The projects are written in **R** and focus on exploratory data analysis, statistical inference, visualization, and predictive modelling.

## Repository structure

```text
Statistical_data_analysis/
│
├── Project1_presentation.Rmd
│
└── Project2/
    ├── bike_train.csv
    ├── bike_test.csv
    ├── kaggle_submission.R
    ├── raport.html
    └── sampleSubmission.csv
```

---

## Authors

**Alicja Rączka & Jakub Maszkowski**

------

## Project 1 – Spotify Data Analysis

This project presents an exploratory statistical analysis of Spotify's all-time top songs dataset.

### Topics covered

- Exploratory Data Analysis (EDA)
- Descriptive statistics
- Data visualization
- Correlation analysis
- Chi-square and Fisher's exact tests
- Linear regression
- Model diagnostics

### Main libraries

- ggplot2
- dplyr
- GGally
- reshape2
- stargazer

---

## Project 2 – Bike Rental Demand Prediction

The goal of this project is to predict the number of bike rentals using weather and calendar-related variables.

### Dataset

The project includes:

- `bike_train.csv` – training dataset
- `bike_test.csv` – test dataset
- `sampleSubmission.csv` – Kaggle submission template

### Workflow

- Data preprocessing
- Feature engineering
- Exploratory Data Analysis
- Principal Component Analysis (PCA)
- Random Forest
- Ridge Regression
- Extra Trees
- Model comparison
- Ensemble learning
- Kaggle submission generation

The final solution combines predictions from Random Forest and Extra Trees models to improve predictive performance.

### Files

| File | Description |
|------|-------------|
| `raport.html` | Full project report |
| `kaggle_submission.R` | Script generating the final Kaggle submission |

---

## Technologies

- R
- RMarkdown
- ggplot2
- dplyr
- tidyr
- ranger
- glmnet
- lubridate
- reshape2
- GGally

---

## Running the projects

### Project 1

Open the RMarkdown file in RStudio and render it:

```r
rmarkdown::render("Project1_presentation.Rmd")
```

### Project 2

Simply run:

```r
source("Project2/kaggle_submission.R")
```

The script automatically loads the provided datasets and generates the final Kaggle submission file.

---

## Author

**Alicja Rączka**
