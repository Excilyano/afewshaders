using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CameraLSD : MonoBehaviour
{
    public Material LSDMaterial;

    void OnRenderImage(RenderTexture src, RenderTexture dst)
    {
        Graphics.Blit(src, dst, LSDMaterial);
    }
}
