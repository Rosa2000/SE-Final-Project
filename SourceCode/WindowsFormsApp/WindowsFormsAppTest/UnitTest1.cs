using Microsoft.VisualStudio.TestTools.UnitTesting;
using WindowsFormsApp;

namespace WindowsFormsApp.Tests
{
    [TestClass()]
    public class UnitTest1
    {
        [TestMethod()]
        public void Form1Test()
        {
            Assert.Fail();
        }
    }
}

namespace WindowsFormsAppTest
{
    [TestClass]
    public class UnitTest1
    {
        [TestMethod]
        public void TestMethod1()
        {
        }
    }
}