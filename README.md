# ML Lead Generating

This repository demonstrates the full machine learning process of training a model on an existing anonymized database, in the hopes of better enhancing the lead generation process.

## About the dataset

The dataset is a `.SQL` file extracted from a proprietary SaaS service.

The objective of the SaaS platform is to build campaigns -using initial and follow-up messages- in order to increase the conversion rate of leads through various other social networks (LinkedIn, Emails, etc...)

## Problem statement

"_What set of messages should be sent to a lead in order to maximize their conversion rate._"

## Getting started

### 1. Dataset

This assumes that you have access to the company data and that you already have the dataset in the [./dataset/actual](./dataset/actual) directory.

If not, you can still try to run the notebook by copying the `.csv` files from the [./dataset/sample](./dataset/sample/) directory but don't expect any good results.

### 2. Dependencies

Configure your python environment of choice, then install the necessary dependencies.

```bash
pip install -r requirements.txt
```

<!-- ## ML Algorithm

This is an unsupervised learning problematic.
It can either be:

- [ ] A recommendation problem

  - [ ] Association rules
  - [ ] Collaborative filtering

OR (if the above does not deliver good results)

- [ ] A Text mining/Natural Language Processing problem

---

- Watson studio (free trial) -->
