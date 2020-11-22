/* 7a */    
class UI
{
    private IDisplayContext ctx;
    private Viewer view;
    public UI(IDisplayContext ctx, Viewer view)
    {
        this.ctx = ctx;
        this.view = view;
    }
    public void ShowImage(byte[] bytes,Viewr view)
    {
        view.Render(ctx, bytes);
    }
}
interface Viewer
{
    public void Render(IDisplayContext ctx,byte[] bytes);
}
class JPG_Viewer : Viewer
{
    public void Render(IDisplayContext ctx,byte[] bytes)
    {
        //rendering code here......
    }
}
class PNG_Viewer:Viewer
{
    public void Render(IDisplayContext ctx, byte[] bytes)
    {
        //rendering code here......
    }
}
class GIF_Viewer : Viewer
{
    public void Render(IDisplayContext ctx, byte[] bytes)
    {
        //rendering code here......
    }
}




/* 7b */
public static void Main()
{
    //code
    Viewer input;
    if(img_bytes[1] == "0x01")
    {
        input = new JPG_Viewer();
    }
    if(img_bytes[1] == "0x02")
    {
        input = new PNG_Viewer();
    }
    if(img_bytes[1] == "0x03")
    {
        input = new GIF_Viewer();
    }
    UI ui = new UI(ctx);
    ui.ShowImage(byte[] bytes,input)
}




/* 7c */
public class ImageController:Controller
{
    public IActionResult DisplayImage()
    {
        ViewData["renderer"] = view;
        return view();
    }
}




/* 8 */
app.Use(async (context,next) =>
{
    DateTime TimeStamp = DateTime.Parse(HttpContext.Request.Cookies["timeStamp"]);
    
    if ((DateTime.Now-TimeStamp).TotalSeconds > 1200)
    {
        HttpContext.Response.Cookies.Delete("TimeStamp");
        context.Response.Redirect("/Login/Index");
        return;
    }

    await next(context);
}
