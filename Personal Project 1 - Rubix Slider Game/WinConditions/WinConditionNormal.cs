using UnityEngine;
using System.Collections;
using UnityEngine.SceneManagement;

public class WinConditionNormal : Variable_Holder {

    public bool Won = false;
    public GameObject ui;

    public void Win()
    {
        if (Won)
        {
            SceneManager.LoadScene(0);
            totalCorrect = 0;
            Won = false;
        }
    }

    void Update()
    {
        /*if(TopR && TopM && TopL && MiddleR && MiddleM && MiddleL && BottomR && BottomM && BottomL)
        {
            Won = true;
            ui.SetActive(true);
        }*/
    }

}
