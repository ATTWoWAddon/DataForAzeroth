local appName, app = ...;

if not DFA_SETTINGS then
    DFA_SETTINGS = {
        ShareAlts = false
    };
end

-- TODO build AddOn Options UI

SLASH_DATAFORAZEROTH1 = "/dfa";
SlashCmdList.DATAFORAZEROTH = function(msg)
    if msg == "shareon" then
        DFA_SETTINGS.ShareAlts = true;
        print("ShareAlts turned on");
    elseif msg == "shareoff" then
        DFA_SETTINGS.ShareAlts = false;
        print("ShareAlts turned off");
    end
end