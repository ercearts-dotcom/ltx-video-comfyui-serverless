# Base image: clean ComfyUI + comfy-cli + comfyui-manager
FROM runpod/worker-comfyui:5.5.1-base

# ── Custom nodes ────────────────────────────────────────────────────────────────
RUN comfy node install --exit-on-fail comfyui-kjnodes@1.3.5 --mode remote
RUN comfy node install --exit-on-fail comfyui-custom-scripts@1.2.5
RUN comfy node install --exit-on-fail ComfyUI-Crystools@1.27.4

# ── Download models into the image (baked-in for fast cold starts via FlashBoot)
# Models land at /comfyui/models/... inside the image.
# ComfyUI also scans /runpod-volume/models/... when a Network Volume is attached,
# so placing files here is NOT required – they are already in the image layer.

RUN comfy model download \
    --url https://huggingface.co/Kijai/LTX2.3_comfy/resolve/main/diffusion_models/ltx-2.3-22b-dev_transformer_only_fp8_scaled.safetensors \
        --relative-path models/diffusion_models \
            --filename ltx-2.3-22b-dev_transformer_only_fp8_scaled.safetensors

            RUN comfy model download \
                --url https://huggingface.co/GitMylo/LTX-2-comfy_gemma_fp8_e4m3fn/resolve/main/gemma_3_12B_it_fp8_e4m3fn.safetensors \
                    --relative-path models/clip \
                        --filename gemma_3_12B_it_fp8_e4m3fn.safetensors

                        RUN comfy model download \
                            --url https://huggingface.co/Kijai/LTX2.3_comfy/resolve/main/text_encoders/ltx-2.3_text_projection_bf16.safetensors \
                                --relative-path models/clip \
                                    --filename ltx-2.3_text_projection_bf16.safetensors

                                    RUN comfy model download \
                                        --url https://huggingface.co/Lightricks/LTX-2.3/resolve/main/ltx-2.3-22b-distilled-lora-384.safetensors \
                                            --relative-path models/loras \
                                                --filename ltx-2.3-22b-distilled-lora-384.safetensors

                                                RUN comfy model download \
                                                    --url https://huggingface.co/Kijai/LTX2.3_comfy/resolve/main/vae/LTX23_audio_vae_bf16.safetensors \
                                                        --relative-path models/vae \
                                                            --filename LTX23_audio_vae_bf16.safetensors

                                                            RUN comfy model download \
                                                                --url https://huggingface.co/Kijai/LTX2.3_comfy/resolve/main/vae/LTX23_video_vae_bf16.safetensors \
                                                                    --relative-path models/vae \
                                                                        --filename LTX23_video_vae_bf16.safetensors
