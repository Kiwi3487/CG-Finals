using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Pixelation : MonoBehaviour
{
    public Material m_pixelateMaterial;
    public int pixelDensity = 200;

    private void OnRenderImage(RenderTexture source, RenderTexture destination)
    {
        float screenWidth = Screen.width;
        float screenHeight = Screen.height;
        Vector2 aspectRatioData;

        if (screenHeight > screenWidth)
        {
            aspectRatioData = new Vector2(screenWidth / screenHeight, 1);
        }
        else
        {
            aspectRatioData = new Vector2(1, screenHeight / screenWidth);
        }
        
        m_pixelateMaterial.SetVector("AspectRatioMultiplier", aspectRatioData);
        
        // Set the pixel density
        m_pixelateMaterial.SetInt("PixelDensity", pixelDensity);

        // Apply the pixelation effect
        Graphics.Blit(source, destination, m_pixelateMaterial);
    }
}