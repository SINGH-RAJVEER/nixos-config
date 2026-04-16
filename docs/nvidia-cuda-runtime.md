# NVIDIA CUDA Runtime

This host uses the proprietary NVIDIA driver with PRIME offload.

Relevant settings in [`configuration.nix`](/home/rajveer/.config/nixos/configuration.nix):

- `services.xserver.videoDrivers = [ "nvidia" ];`
- `hardware.graphics.enable = true;`
- `hardware.graphics.enable32Bit = true;`
- `hardware.nvidia.open = false;`
- `hardware.nvidia.prime.offload.enable = true;`
- `hardware.nvidia.prime.amdgpuBusId = "PCI:102:0:0";`
- `hardware.nvidia.prime.nvidiaBusId = "PCI:101:0:0";`

The bus IDs above come from the actual PCI devices on this machine:

- AMD display controller: `0000:66:00.0 -> PCI:102:0:0`
- NVIDIA GeForce RTX 4060 Laptop GPU: `0000:65:00.0 -> PCI:101:0:0`

After rebuilding and rebooting, verify the runtime before debugging CUDA userspace:

```bash
ls -l /dev/nvidia*
ls -l /run/opengl-driver/lib/libcuda.so*
nvidia-smi
python -c "import torch; print(torch.cuda.is_available(), torch.cuda.device_count())"
```
