package ex2;

import java.util.concurrent.locks.Condition;
import java.util.concurrent.locks.ReentrantLock;


public class Item {

    private ReentrantLock lock;
    private Condition isEmpty;
    private int quantity;

    public Item() {
        this.lock = new ReentrantLock();
        this.isEmpty = this.lock.newCondition();
        this.quantity = 0;
    }

    public void supply(int quantity) {
        this.quantity += quantity;
        isEmpty.signalAll();
        System.out.println("Acrescentaram-me um");
    }

    public void consume() {
       if(this.quantity == 0) {
           try {
               this.isEmpty.await();
           }
           catch(Exception e) {

           }
       }
       if(this.quantity > 0)  {
           this.quantity--;
           System.out.println("Foderam-me um");
       }
    }

    public void lock() {
       this.lock();
    }

    public void unlock() {
       this.unlock();
    }
}
