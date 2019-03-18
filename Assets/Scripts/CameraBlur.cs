using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CameraBlur : MonoBehaviour
{
    public Material BlurMaterial;

    void OnRenderImage(RenderTexture src, RenderTexture dst)
    {
        Graphics.Blit(src, dst, BlurMaterial);
    }
}