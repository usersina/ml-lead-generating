import numpy as np
from flask import Blueprint, request

from .helpers import load_model_and_matrix

bp = Blueprint("routes", __name__)

model, user_item_matrix, index_to_message_id, messages_raw_df = load_model_and_matrix()


@bp.route("/recommend", methods=["GET"])
def recommend():
    # Get the lead id from the request
    lead_id = request.args.get("leadId")
    if lead_id is None:
        return {"success": False, "message": "No lead id is provided"}

    # Generate recommendations
    transformed_matrix = model.transform(user_item_matrix)
    user_vector = transformed_matrix[int(lead_id), :]
    scores = np.dot(user_vector, model.components_)
    recommended_item_indices = np.argsort(scores)[::-1]
    recommended_message_ids = [
        index_to_message_id[index] for index in recommended_item_indices
    ]

    recommended_messages = messages_raw_df[
        messages_raw_df["messageId"].isin(recommended_message_ids)
    ]
    recommended_messages = recommended_messages.groupby("order").first().reset_index()

    return {"success": True, "data": recommended_messages.to_dict(orient="records")}
