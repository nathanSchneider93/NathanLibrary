using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class LerpValue : MonoBehaviour
{
    public Material mat;

	void Update ()
    {
        mat.SetFloat("_LerpValue", 1 + Mathf.Sin(Time.time));		
	}
}
