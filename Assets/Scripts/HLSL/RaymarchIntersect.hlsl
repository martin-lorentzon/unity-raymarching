//Based on code from DMEville https://www.youtube.com/watch?v=0G8CVQZhMXw

// sceneDepth = Scene Depth node set to Eye
// surfaceDepth = Eye depth of the current fragment position

void raymarch_float( float3 rayOrigin, float3 rayDirection, int numSteps, float stepSize,
                     float densityScale, UnityTexture3D volumeTex, UnitySamplerState volumeSampler,
                     float3 offset, int numLightSteps, float lightStepSize, float3 lightDir,
                     float lightAbsorb, float darknessThreshold, float transmittance,
                     float sceneDepth, float surfaceDepth, out float3 result )
{
    float density = 0;
    float finalLight = 0;

    // Distance available before opaque geometry.
    float maxDistance = max(sceneDepth - surfaceDepth, 0);
    
    float traveled = 0;

    for (int i = 0; i < numSteps; i++)
    {
        traveled += stepSize;

        // Stop raymarch at scene depth.
        if (traveled >= maxDistance)
            break;

        rayOrigin += rayDirection * stepSize;

        float3 samplePos = rayOrigin + offset;

        float sampledDensity = SAMPLE_TEXTURE3D_LOD(volumeTex, volumeSampler, samplePos, 0).r;

        sampledDensity *= densityScale;

        density += sampledDensity;

        // Light march
        float lightAccumulation = 0;
        float3 lightPos = samplePos;

        for (int j = 0; j < numLightSteps; j++)
        {
            lightPos += -lightDir * lightStepSize;
            lightAccumulation += SAMPLE_TEXTURE3D_LOD(volumeTex, volumeSampler, lightPos, 0).r;
        }
        
        float lightTransmission = exp(-lightAccumulation);
        
        float illumination = lerp(darknessThreshold, 1.0, lightTransmission);

        finalLight += sampledDensity * transmittance * illumination;
        
        transmittance *= exp(-sampledDensity * lightAbsorb);
    }

    float transmission = exp(-density);
    
    result = float3(finalLight, transmission, transmittance);
}