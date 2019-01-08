using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using UnityEngine.SceneManagement;

public class WinConditionsNumbers : Variable_Holder {

    int[] Interval1 = new int[9] { 1, 2, 3, 4, 5, 6, 7, 8, 9 };
    public GameObject[] GInterval1 = new GameObject[9];

    int RandomNumber;
    int NRow1, NRow2, NRow3;
    public Text Row1, Row2, Row3, TwoRow1, TwoRow2, TwoRow3, won;

    // Use this for initialization
    void Awake () {
        for (int i = 0; i < 9; i++)
        {
                int NumberPicked = Interval1[RandomNumber = Random.Range(0, 9)];
                while (NumbersToPick.Contains(NumberPicked))
                {
                    NumberPicked = Interval1[RandomNumber = Random.Range(0, 9)];
                }

                if (!NumbersToPick.Contains(NumberPicked))
                {
                    NumbersToPick.Add(NumberPicked);
                    ObjectsToPick.Add(GInterval1[RandomNumber]);
                }      
        }

        for(int i = 0; i < 9; i++)
        {
            switch (i)
            {
                case 0:
                    Instantiate(ObjectsToPick[i], new Vector3(1,6,0), transform.rotation);
                    break;
                case 1:
                    Instantiate(ObjectsToPick[i], new Vector3(3, 6, 0), transform.rotation);
                    break;
                case 2:
                    Instantiate(ObjectsToPick[i], new Vector3(5, 6, 0), transform.rotation);
                    break;
                case 3:
                    Instantiate(ObjectsToPick[i], new Vector3(1, 4, 0), transform.rotation);
                    break;
                case 4:
                    Instantiate(ObjectsToPick[i], new Vector3(3, 4, 0), transform.rotation);
                    break;
                case 5:
                    Instantiate(ObjectsToPick[i], new Vector3(5, 4, 0), transform.rotation);
                    break;
                case 6:
                    Instantiate(ObjectsToPick[i], new Vector3(1, 2, 0), transform.rotation);
                    break;
                case 7:
                    Instantiate(ObjectsToPick[i], new Vector3(3, 2, 0), transform.rotation);
                    break;
                case 8:
                    Instantiate(ObjectsToPick[i], new Vector3(5, 2, 0), transform.rotation);
                    NRow1 = NumbersToPick[0] + NumbersToPick[1] + NumbersToPick[2];
                    NRow2 = NumbersToPick[3] + NumbersToPick[4] + NumbersToPick[5];
                    NRow3 = NumbersToPick[6] + NumbersToPick[7] + NumbersToPick[8];
                    Debug.Log(NumbersToPick[0] + " " + NumbersToPick[1] + " " + NumbersToPick[2]);
                    Debug.Log(NumbersToPick[3] + " " + NumbersToPick[4] + " " + NumbersToPick[5]);
                    Debug.Log(NumbersToPick[6] + " " + NumbersToPick[7] + " " + NumbersToPick[8]);
                    break;
            }
        }

    }
	
    void Start()
    {
        TwoRow1.text = "" + NRow1;
        TwoRow2.text = "" + NRow2;
        TwoRow3.text = "" + NRow3;
    }

    void Update()
    {
        if(NRow1 == ARow1 && NRow2 == ARow2 && NRow3 == ARow3 && TopR && TopM && TopL && MiddleR && MiddleM && MiddleL && BottomR && BottomM && BottomL)
        {
            won.text = "Solved!";
        }
        Row1.text = "" + ARow1;
        Row2.text = "" + ARow2;
        Row3.text = "" + ARow3;
    }

    public void Reload()
    {
        SceneManager.LoadScene(0);
    }
}
