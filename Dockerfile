# clean base image containing only comfyui, comfy-cli and comfyui-manager
FROM runpod/worker-comfyui:5.5.1-base

# install custom nodes into comfyui (first node with --mode remote to fetch updated cache)
RUN comfy node install --exit-on-fail comfyui-kjnodes@1.3.5 --mode remote
RUN comfy node install --exit-on-fail comfyui-custom-scripts@1.2.5
RUN comfy node install --exit-on-fail ComfyUI-Crystools@1.27.4
# The workflow references additional custom nodes from an unknown registry group but no aux_id (GitHub repo) was provided for them,
# so they cannot be automatically installed. Example node types that were skipped: SetNode, GetNode, Switch any [Crystools] (these come from the unknown_registry group).

# download models into comfyui
RUN comfy model download --url https://huggingface.co/Kijai/LTX2.3_comfy/blob/main/diffusion_models/ltx-2.3-22b-dev_transformer_only_fp8_scaled.safetensors --relative-path models/diffusion_models --filename ltx-2.3-22b-dev_transformer_only_fp8_scaled.safetensors
RUN comfy model download --url https://huggingface.co/GitMylo/LTX-2-comfy_gemma_fp8_e4m3fn/blob/main/gemma_3_12B_it_fp8_e4m3fn.safetensors --relative-path models/clip --filename gemma_3_12B_it_fp8_e4m3fn.safetensors
RUN comfy model download --url https://huggingface.co/Kijai/LTX2.3_comfy/blob/main/text_encoders/ltx-2.3_text_projection_bf16.safetensors --relative-path models/clip --filename ltx-2.3_text_projection_bf16.safetensors
RUN comfy model download --url https://huggingface.co/Lightricks/LTX-2.3/blob/main/ltx-2.3-22b-distilled-lora-384.safetensors --relative-path models/loras --filename ltx-2.3-22b-distilled-lora-384.safetensors
RUN comfy model download --url https://huggingface.co/Kijai/LTX2.3_comfy/blob/main/vae/LTX23_audio_vae_bf16.safetensors --relative-path models/vae --filename LTX23_audio_vae_bf16.safetensors
RUN comfy model download --url https://huggingface.co/Kijai/LTX2.3_comfy/blob/main/vae/LTX23_video_vae_bf16.safetensors --relative-path models/vae --filename LTX23_video_vae_bf16.safetensors

# copy all input data (like images or videos) into comfyui (uncomment and adjust if needed)
# COPY input/ /comfyui/input/
