/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Exceptions;

/**
 *
 * @author Ajai Gill
 */
public class InvalidGradeException extends NumberFormatException {
    public InvalidGradeException()
    {
        super("Invalid Grade!");
    }
}
