using UnityEngine;
using System.Collections;
using System.Collections.Generic;

public class RandomizePlacements : Variable_Holder {

    int[] Numbers = new int[16] {11,12,13,14,21,22,23,24,31,32,33,34,41,42,43,44};

    // Use this for initialization
    void Awake()
    {
        for(int i = 0; i < 21; i++)
        {
            Direction.Add(Numbers[Random.Range(0, 16)]);
        }
    }
}
