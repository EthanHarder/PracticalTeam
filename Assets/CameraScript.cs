using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CameraScript : MonoBehaviour
{

    public Material m_renderMaterial;

    bool _hit = false;

    void Update()
    {
        if (Input.GetKeyDown(KeyCode.LeftShift))
        {
            StartCoroutine(HitDuration());
        }
    }




    IEnumerator HitDuration()
    {
        _hit = true;
        yield return new WaitForSeconds(0.2f);

        _hit = false;
    }

    void OnRenderImage(RenderTexture source, RenderTexture destination)
    {
        if (_hit)
        {
            m_renderMaterial.SetFloat("_Contribution", 1);
        }
        else
        {
            m_renderMaterial.SetFloat("_Contribution", 0);
        }
        
            Graphics.Blit(source, destination, m_renderMaterial);
        
  
    }
}
