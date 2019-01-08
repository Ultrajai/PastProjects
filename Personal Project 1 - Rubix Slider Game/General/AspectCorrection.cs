using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class AspectCorrection : MonoBehaviour {

	// Use this for initialization
	void Start () {

        float targetaspect = 10.0f / 16.0f;

        float windowaspect = (float)Screen.width / (float)Screen.height;

        float scaleheight = targetaspect / windowaspect;

        Camera camera = GetComponent<Camera>();

        camera.orthographicSize = camera.orthographicSize * scaleheight;
    }
	
}
