# ML Lead Generating

This repository demonstrates the machine learning process of training a model on an existing anonymized database, in the hopes of better enhancing the lead generation process.

## About the dataset

The dataset is multiple `.csv` files extracted from a proprietary SaaS service.

The objective of the SaaS platform is to build campaigns -using initial and follow-up messages- in order to increase the conversion rate of leads through various other social networks (LinkedIn, Emails, etc...)

## Problem statement

"_What set of messages should be sent to a lead in order to maximize their conversion rate._"

## To keep in mind

The defined problem statement only works with the existing system messages, which is why this can be considered as a recommendation problem.

A better problem statement would be the following:

> "_What set of messages should be generated per campaign so that we have maximum conversion for all campaign leads_"

This implies that this problem would need to be approached in a different light. E.g. as a Natural Language Processing problem.

## Getting started

### 1. Dataset

This assumes that you have access to the company data and that you already have the dataset in the [./dataset/actual](./dataset/actual) directory.

If not, you can still try to run the notebook by copying the `.csv` files from the [./dataset/sample](./dataset/sample/) directory but don't expect any good results.

### 2. Dependencies

Configure your python environment of choice, then install the necessary dependencies.

```bash
pip install -r requirements.txt
```

### 3. Using the web server

You can directly check the most optimal messages to send with a lead by specifying their id in the `/recommend` endpoint as follows:

```bash
curl -X GET 'http://localhost:5000/recommend?leadId=39280'
```

## Example use case

This sections explains how the LinkedIn lead generation works in the context of dataframes.

There is an explicit interaction between all dataframes as follows:

`campaigns_df`:
This contains the total numbers of invites sent, invites accepted, etc for all campaigns of the application. It also has the `id` field.

`messages_df`:
This contains the actual messages to be sent to a lead. Each message is uniquely identified by the combination of `campaignId` and `oder`. The `campaignId` maps to `campaigns_df.id`.
Order = 0 means that this is the initial invite message
Order = 1 means that this is the first follow up message
Order = 2 means that this is the second follow up message
And so on until a maximum of Order = 5

`leads_df`:
This contains the list of all leads. Note that each row contains whether this lead was invited, whether they accepted the connection request, whether they replied, and whether any follow ups were sent to them.

For the record, the logic works as follows in the application:

- An invite is sent to a lead (message with order 0), mark the `isInviteSent` and wait for their reply.
- If they do reply, then set the `isReplied` to true and consider this lead as a successful conversion.
- If they do not reply, then send follow up messages (order 1 through 5) until they do reply to the earliest one. There is an interval between each sending of a follow up so that the leads are not spammed. When a follow up is sent, the corresponding boolean value is to true. (Example, if a follow up message with order = 1 is sent, then the `isFirstFollowUpSent` flag is set to true on the `leads_df` for that specific lead)
