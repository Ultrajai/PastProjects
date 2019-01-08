using UnityEngine;
using System.Collections;
using System.Collections.Generic;

public class Variable_Holder : MonoBehaviour {

    static public bool Vertical = false;
    static public bool Horizontal = false;
    static public bool LetGo = true;
    public static bool CanSwipe = true;
    static public Vector3 TouchInWorld;
    static public Vector2 TouchInWorld2DB = new Vector2(-1, -1);
    public static bool TopR, TopM, TopL, MiddleR, MiddleM, MiddleL, BottomR, BottomM, BottomL;
    public static int totalCorrect = 0;
    public static List<int> Direction = new List<int>();
    public static bool Randomized = false;
    public static List<int> NumbersToPick = new List<int>();
    public static List<GameObject> ObjectsToPick = new List<GameObject>();
    public static Transform Tetherer;
    public static int ARow1, ARow2, ARow3;
    public static Vector3[] PStationary = new Vector3[41];

    void Start()
    {
        Tetherer = this.transform;
    }

}
