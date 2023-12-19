import os
import pickle
from typing import Any

from pandas import DataFrame
from sklearn.decomposition import TruncatedSVD


def load_model_and_matrix() -> (
    tuple[TruncatedSVD, DataFrame, dict[int, Any], DataFrame]
):
    """
    Load the model and user-item matrix from pickles.
    """

    model: TruncatedSVD | None = None
    user_item_matrix: DataFrame | None = None
    index_to_message_id: dict[int, Any] | None = None
    messages_raw_df: DataFrame | None = None

    pickles_dir = os.path.join(os.path.dirname(os.path.abspath(__file__)), "pickles")

    errors = []

    with open(os.path.join(pickles_dir, "model.pkl"), "rb") as file:
        model = pickle.load(file)
    if model is None:
        errors.append("Model is None")

    with open(os.path.join(pickles_dir, "user_item_matrix.pkl"), "rb") as file:
        user_item_matrix = pickle.load(file)
    if user_item_matrix is None:
        errors.append("User-item matrix is None")

    with open(os.path.join(pickles_dir, "index_to_message_id.pkl"), "rb") as file:
        index_to_message_id = pickle.load(file)
    if index_to_message_id is None:
        errors.append("Index to message id is None")

    with open(os.path.join(pickles_dir, "messages_raw_df.pkl"), "rb") as file:
        messages_raw_df = pickle.load(file)
    if messages_raw_df is None:
        errors.append("Messages raw df is None")

    if errors:
        raise ValueError("Errors occurred while loading pickles: " + ", ".join(errors))

    return model, user_item_matrix, index_to_message_id, messages_raw_df  # type: ignore # Safe to ignore
