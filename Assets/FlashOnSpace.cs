using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class FlashOnSpace : MonoBehaviour
{

    bool empowered;
    
    void Update()
    {
        if (Input.GetKeyDown(KeyCode.Space))
        {
            empowered = !empowered;

            GetComponent<Renderer>().material.SetFloat("_doFlash", empowered ? 1.0f : 0.0f);
        }
    }
}
