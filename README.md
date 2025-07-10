
# GG9 Terraform Module for GCP

This module deploys the GG9 Java application to Google Cloud Platform.

* **Single‑node** – when `nodes_count = 1` a standalone `google_compute_instance` is created.
# To be specified

Consumption‑tracking and any other labels are injected through the variable
`marketplace_labels`; the module passes them to **all** resources via the
`default_labels` field of the Google provider.

> Docs: https://registry.terraform.io/providers/hashicorp/google/latest/docs/guides/provider_reference#default_labels-1
